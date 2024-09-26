import SwiftUI

public
protocol ItemViewFactory {
    associatedtype ViewType: View
    @ViewBuilder func build(
        _ viewState: any ItemViewState,
        action: @escaping ItemAction
    ) -> ViewType
}

public
class EmptyItemViewFactory: ItemViewFactory {
    public typealias ViewType = EmptyView
    
    public init() { }
    
    public func build(
        _ viewState: any ItemViewState,
        action: @escaping ItemAction
    ) -> ViewType {
        EmptyView()
    }
}
