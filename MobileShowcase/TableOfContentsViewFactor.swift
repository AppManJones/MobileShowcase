import Layout
import SwiftUI

class TableOfContentsViewFactor: ItemViewFactory {
    @ViewBuilder
    func build(_ viewState: any ItemViewState, action: @escaping ItemAction) -> some View {
        switch viewState {
        case let state as TableOfContentsItemState:
            TableOfContentsItem(action: action, viewState: state)
        case let state as TableOfContentsSectionState:
            TableOfContentsSection(viewState: state, itemFactory: self, action: action)
        default:
            EmptyItemViewFactory().build(viewState, action: action)
        }
    }
}
