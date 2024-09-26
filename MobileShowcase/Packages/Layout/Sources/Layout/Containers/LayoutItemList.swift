import SwiftUI

public struct LayoutItemList<ViewFactory: ItemViewFactory>: View {
    private let action: ItemAction
    private let factory: ViewFactory
    private let itemStore: ItemStore

    public init(
        action: @escaping ItemAction,
        factory: ViewFactory,
        itemStore: ItemStore
    ) {
        self.action = action
        self.factory = factory
        self.itemStore = itemStore
    }

    public var body: some View {
        List(itemStore.items) { anyItem in
            factory.build(anyItem.viewState, action: action)
        }
    }
}
