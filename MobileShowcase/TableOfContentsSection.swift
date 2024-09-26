import Layout
import SwiftUI

struct TableOfContentsSection<ViewFactory: ItemViewFactory>: LayoutItem {
    let viewState: TableOfContentsSectionState
    let itemFactory: ViewFactory
    let action: ItemAction
    
    init(
        viewState: TableOfContentsSectionState,
        itemFactory: ViewFactory,
        action: @escaping ItemAction
    ) {
        self.viewState = viewState
        self.itemFactory = itemFactory
        self.action = action
    }
    
    var body: some View {
        Section(header: Text(viewState.title)) {
            ForEach(viewState.itemStore.items) { anyItem in
                itemFactory.build(anyItem.viewState, action: action)
            }
        }
    }
}

struct TableOfContentsSectionState: ItemViewState, Equatable {
    let itemStore: ItemStore
    let title: String
    let id: AnyHashable
    
    init(
        itemStore: ItemStore,
        title: String,
        id: AnyHashable
    ) {
        self.itemStore = itemStore
        self.title = title
        self.id = id
    }
}
