import SwiftUI

public protocol ItemViewFactory {
    associatedtype ViewType: View
    @ViewBuilder func build(
        _ viewState: any ItemViewState,
        action: @escaping ItemAction
    ) -> ViewType
}
