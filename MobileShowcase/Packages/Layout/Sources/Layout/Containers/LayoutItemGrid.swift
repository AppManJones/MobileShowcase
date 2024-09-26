import SwiftUI

public struct LayoutItemGrid<ViewFactory: ItemViewFactory>: View {
    private let action: ItemAction
    private let factory: ViewFactory
    private let gridLayout: [GridItem]
    private let itemStore: ItemStore

    public init(
        action: @escaping ItemAction,
        factory: ViewFactory,
        gridLayout: [GridItem] = [GridItem(.flexible()), GridItem(.flexible())],
        itemStore: ItemStore
    ) {
        self.action = action
        self.factory = factory
        self.gridLayout = gridLayout
        self.itemStore = itemStore
    }

    public var body: some View {
        LazyVGrid(columns: gridLayout) {
            ForEach(itemStore.items) { anyItem in
                factory.build(anyItem.viewState,
                              action: action)
            }
        }
        .gridCellAnchor(UnitPoint.bottomTrailing)
        .gridCellAnchor(UnitPoint.topLeading)
        .gridCellAnchor(UnitPoint.topTrailing)
    }
}
