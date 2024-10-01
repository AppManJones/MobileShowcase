import SwiftUI

//  MARK: Model

struct TodoItem : Sendable, Identifiable, Equatable {
    let id: String
    let isComplete: Bool
    let title: String
}

struct ViewState: Equatable {
    let error: Error?
    let items: [TodoItem]
    let title: String
    let undoEnabled: Bool
    init(
        error: Error? = nil,
        items: [TodoItem] = [],
        title: String = "Todo List",
        undoEnabled: Bool = false
    ) {
        self.error = error
        self.items = items
        self.title = title
        self.undoEnabled = undoEnabled
    }
    
    static func == (lhs: ViewState, rhs: ViewState) -> Bool {
        return lhs.items == rhs.items &&
               lhs.title == rhs.title &&
               lhs.undoEnabled == rhs.undoEnabled &&
               (lhs.error?.localizedDescription == rhs.error?.localizedDescription)
    }
}

//  MARK: View Layer

enum ViewEvent {
    case launch
    case refresh
    case undo
    case update(TodoItem, Bool)
}

struct ContentView: View {
    
    @StateObject private var viewModel: ViewModel
    
    init(
        viewModel: ViewModel = .init()
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            List(viewModel.viewState.items, id: \.id) { item in
                row(for: item)
            }
            .refreshable {
                handleRefresh()
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(viewModel.viewState.title)
                        .font(.headline)
                        .padding()
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: handleUndo) {
                        Image(systemName: "arrow.uturn.left")
                            .foregroundColor(viewModel.viewState.undoEnabled ? .black : .gray)
                    }
                    .accessibilityLabel("Undo")
                    .disabled(!viewModel.viewState.undoEnabled)
                }
            }
        }
        .onAppear {
            handleLaunch()
        }
    }
    
    private func row(for item: TodoItem) -> some View {
        Toggle(isOn: Binding(get: { item.isComplete },
                             set: { isComplete in handleUpdate(item, isComplete) }))
        {
            Text(item.title)
                .font(.body)
                .padding()
        }
    }
}

private extension ContentView {
    func handleLaunch() {
        viewModel.handle(event: .launch)
    }
    
    func handleRefresh() {
        viewModel.handle(event: .refresh)
    }
    
    func handleUndo() {
        viewModel.handle(event: .undo)
    }
    
    func handleUpdate(_ item: TodoItem, _ isComplete: Bool) {
        viewModel.handle(event: .update(item, isComplete))
    }
}

//  MARK: Presentation Layer

@MainActor
final class ViewModel: ObservableObject {
    
    @Published var viewState: ViewState
    
    private let interactor: DomainInteractor
    private let reducer: ViewStateReducer
    
    init(
        interactor: DomainInteractor = .init(),
        reducer: ViewStateReducer = .init(),
        viewState: ViewState = .init()
    ) {
        self.interactor = interactor
        self.reducer = reducer
        self.viewState = viewState
    }
    
    func handle(event: ViewEvent) {
        Task {
            switch event {
            case .launch:
                await handleLaunch()
            case .refresh:
                await handleRefresh()
            case .undo:
                await handleUndo()
            case .update(let todoItem, let isComplete):
                await handleUpdate(todoItem, isComplete)
            }
        }
    }
}

@MainActor
private extension ViewModel {
    func setViewStateIfChanged(newViewState: ViewState) {
        guard self.viewState != newViewState else { return }
        self.viewState = newViewState
    }
    
    func handleLaunch() async {
        let domainState = await interactor.handle(action: .fetchData)
        let viewState = reducer.reduce(domainState: domainState, into: viewState)
        setViewStateIfChanged(newViewState: viewState)
    }
    
    func handleRefresh() async {
        let domainState = await interactor.handle(action: .refresh)
        let viewState = reducer.reduce(domainState: domainState, into: viewState)
        setViewStateIfChanged(newViewState: viewState)
    }
    
    func handleUndo() async {
        let domainState = await interactor.handle(action: .undo)
        let viewState = reducer.reduce(domainState: domainState, into: viewState)
        setViewStateIfChanged(newViewState: viewState)
    }
    
    func handleUpdate(_ todoItem: TodoItem, _ isComplete: Bool) async {
        let domainState = await interactor.handle(action: .update(todoItem, isComplete))
        let viewState = reducer.reduce(domainState: domainState, into: viewState)
        setViewStateIfChanged(newViewState: viewState)
    }
}

final class ViewStateReducer {
    
    func reduce(domainState: DomainState, into viewState: ViewState) -> ViewState {
        if let error = domainState.error {
            return .init(error: error, undoEnabled: viewState.undoEnabled)
        }
        return ViewState(items: domainState.data, undoEnabled: domainState.canUndo)
    }
}

//  MARK: Domain Layer

enum DomainAction {
    case fetchData
    case refresh
    case undo
    case update(TodoItem, Bool)
}

enum DomainError: Error {
    case linkUnavailable
    case parseError
    case requestFailed
    case unknown
}

struct DomainState : Sendable{
    let error: DomainError?
    let data: [TodoItem]
    let canUndo: Bool
    init(
        error: DomainError? = nil,
        data: [TodoItem] = [],
        canUndo: Bool = false
    ) {
        self.error = error
        self.data = data
        self.canUndo = canUndo
    }
}

actor DomainInteractor {
    
    private var domainStateStack: [DomainState] = []
    private let maxHistorySize = 10
    
    func handle(action: DomainAction) async -> DomainState {
        switch action {
        case .fetchData:
            do {
                return try await fetchData()
            } catch {
                return DomainState(error: DomainError.requestFailed)
            }
        case .refresh:
            do {
                return try await refreshData()
            } catch {
                return DomainState(error: DomainError.requestFailed)
            }
        case .undo:
            do {
                return try await popDomainState()
            } catch {
                return DomainState(error: DomainError.requestFailed)
            }
        case .update(let item, let isComplete):
            do {
                return try await update(item, isComplete)
            } catch {
                return DomainState(error: DomainError.requestFailed)
            }
        }
    }
}

private extension DomainInteractor {
    private func addStateToStack(_ state: DomainState) {
        domainStateStack.append(state)
        if domainStateStack.count > maxHistorySize {
            domainStateStack.removeFirst()
        }
    }
    
    private func fetchData() async throws -> DomainState {
        let state = DomainState(data: [
            TodoItem(id: "0", isComplete: false, title: "Do Laundry"),
            TodoItem(id: "1", isComplete: false, title: "Pickup Groceries"),
            TodoItem(id: "2", isComplete: false, title: "Feed the Dog"),
            TodoItem(id: "3", isComplete: false, title: "Make Dinner"),
            TodoItem(id: "4", isComplete: false, title: "Do the Dishes")
        ], canUndo: false)
        
        addStateToStack(state)
        return state
    }
    
    func refreshData() async throws -> DomainState {
        guard let currentDomainState = domainStateStack.last else { return .init(error: .unknown) }
        return currentDomainState
    }
    
    private func popDomainState() async throws -> DomainState {
        guard domainStateStack.count > 1 else { return domainStateStack.last ?? .init(error: .unknown) }
        domainStateStack.removeLast()
        return domainStateStack.last ?? .init(error: .unknown)
    }
    
    private func update(_ todoItem: TodoItem, _ isComplete: Bool) async throws -> DomainState {
        guard let currentDomainState = domainStateStack.last else { return .init(error: .unknown) }
        
        var items = currentDomainState.data
        if let itemIndex = items.firstIndex(where: { $0.id == todoItem.id }) {
            let newItem = TodoItem(id: todoItem.id, isComplete: isComplete, title: todoItem.title)
            items[itemIndex] = newItem
        }

        let newState = DomainState(data: items, canUndo: true)
        addStateToStack(newState)
        return newState
    }
}
