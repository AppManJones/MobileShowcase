import SwiftUI

@MainActor
public class LayoutSystemViewFactor: @preconcurrency ItemViewFactory {
    public init() {}
    @ViewBuilder
    public func build(_ viewState: any ItemViewState, action: @escaping ItemAction) -> some View {
        switch viewState {
        case let state as MenuItemState:
            MenuItem(action: action, viewState: state)
        case let state as ListSectionViewState:
            ListSection(viewState: state, itemFactory: self, action: action)
        default:
            EmptyItemViewFactory().build(viewState, action: action)
        }
    }
}
