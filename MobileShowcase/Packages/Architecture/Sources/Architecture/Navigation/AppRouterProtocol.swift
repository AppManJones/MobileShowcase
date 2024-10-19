import SwiftUI

public
protocol AppRouterProtocol: ObservableObject {
    
    associatedtype NavigationEvent: Equatable
    associatedtype Screen: ScreenProtocol
    associatedtype Sheet: ScreenProtocol = Screen
    associatedtype FullScreenCover: ScreenProtocol = Screen
    associatedtype V: View
    
    var fullScreenCover: Screen? { get set }
    var path: NavigationPath { get set }
    var sheet: Screen? { get set }

    func build(_ screen: Screen) -> V
    func build(_ sheet: Sheet) -> V
    func build(_ fullScreenCover: FullScreenCover) -> V
    func handle(_ event: NavigationEvent)
}
