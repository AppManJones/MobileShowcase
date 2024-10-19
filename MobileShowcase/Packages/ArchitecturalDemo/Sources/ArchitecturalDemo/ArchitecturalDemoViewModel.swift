import Architecture
import Foundation

enum ArchitecturalDemoViewEvent: ViewEventProtocol {
    case didLoad
    case didSelect(Int)
    case didTapNextPage
}

struct ArchitecturalDemoViewState: StateProtocol {
    let content: String
    let id: Int
    init(
        content: String = "",
        id: Int = .random(in: 0...Int.max)
    ) {
        self.content = content
        self.id = id
    }
}

final
class ArchitecturalDemoViewModel: ViewModel {
    
    @Published var viewState: ArchitecturalDemoViewState
    @Published var navigationEvent: NavigationEvent = .none
    
    let domain: ArchitecturalDemoDomain
    let reducer: ArchitecturalDemoReducer
    
    init(
        domain: ArchitecturalDemoDomain,
        reducer: ArchitecturalDemoReducer,
        viewState: ArchitecturalDemoViewState
    ) {
        self.domain = domain
        self.reducer = reducer
        self.viewState = viewState
    }

    func handle(_ viewEvent: ArchitecturalDemoViewEvent) async {
        switch  viewEvent {
        case .didLoad:
            await handleDidLoad()
        case .didSelect(let index):
            await handleDidSelect(index)
        case .didTapNextPage:
            await handleDidTapNextPage()
        }
    }
}

@MainActor private
extension ArchitecturalDemoViewModel {
    func setViewStateIfChanged(newViewState: ArchitecturalDemoViewState) {
        guard self.viewState != newViewState else { return }
        self.viewState = newViewState
    }
    
    func handleDidLoad() async {
        let domainState = await domain.handle(.fetch)
        let viewState = reducer.reduce(domainState, into: viewState)
        setViewStateIfChanged(newViewState: viewState)
    }
    
    func handleDidSelect(_ index: Int) async {
        let domainState = await domain.handle(.fetch)
        let viewState = reducer.reduce(domainState, into: viewState)
        setViewStateIfChanged(newViewState: viewState)
    }
    
    func handleDidTapNextPage() async {
        navigationEvent = .showScreen(.pageTwo)
    }
}
