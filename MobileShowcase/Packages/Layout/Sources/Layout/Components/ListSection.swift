import SwiftUI

public
struct ListSection<ViewFactory: ItemViewFactory>: LayoutItem {
    public let viewState: ListSectionViewState
    let itemFactory: ViewFactory
    let action: ItemAction
    
    public init(
        viewState: ListSectionViewState,
        itemFactory: ViewFactory,
        action: @escaping ItemAction
    ) {
        self.viewState = viewState
        self.itemFactory = itemFactory
        self.action = action
    }
    
    public var body: some View {
        Section(header: Text(viewState.title)) {
            ForEach(viewState.itemStore.items) { anyItem in
                itemFactory.build(anyItem.viewState, action: action)
            }
        }
    }
}

public
struct ListSectionViewState: ItemViewState, Equatable {
    let itemStore: ItemStore
    let title: String
    public let id: AnyHashable
    
    public init(
        itemStore: ItemStore,
        title: String,
        id: AnyHashable
    ) {
        self.itemStore = itemStore
        self.title = title
        self.id = id
    }
}
