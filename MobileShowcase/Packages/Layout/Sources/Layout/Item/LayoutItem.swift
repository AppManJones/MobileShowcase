import SwiftUI

public protocol LayoutItem: View {
    associatedtype ViewState: ItemViewState
    var viewState: ViewState { get }
}
