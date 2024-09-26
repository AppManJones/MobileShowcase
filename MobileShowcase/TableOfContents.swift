import SwiftUI
import Layout

struct TableOfContents: View {

    @StateObject
    public var viewModel: TableOfContentsMenuViewModel
    
    init(viewModel: TableOfContentsMenuViewModel? = nil) {
        _viewModel = StateObject(wrappedValue: viewModel ?? TableOfContentsMenuViewModel())
    }
    
    var body: some View {
        LayoutItemList(
            action: didSelectRow,
            factory: TableOfContentsViewFactor(),
            itemStore: viewModel.viewState.itemStore)
    }
}

private extension TableOfContents {
    func didSelectRow(_ actionItem: Any) {
        
    }
}

final
class TableOfContentsMenuViewModel: ObservableObject {
    @Published var viewState: TableOfContentsMenuViewState
    
    private let viewStateFactory: TableOfContentsViewStateFactory
    
    init(
        viewState: TableOfContentsMenuViewState = TableOfContentsMenuViewState(),
        viewStateFactory: TableOfContentsViewStateFactory = TableOfContentsViewStateFactory()
    ) {
        self.viewState = viewState
        self.viewStateFactory = viewStateFactory
        createViewState()
    }
    
    private func createViewState() {
        let state = viewStateFactory.sections(for: .root)
        self.viewState = TableOfContentsMenuViewState(itemStore: ItemStore(state))
    }
}

struct TableOfContentsMenuViewState {
    let itemStore: ItemStore
    public init(itemStore: ItemStore = ItemStore(items: [])) {
        self.itemStore = itemStore
    }
}

#Preview {
    TableOfContents()
}
