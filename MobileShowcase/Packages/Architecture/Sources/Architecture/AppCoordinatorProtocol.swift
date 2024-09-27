import SwiftUI

public
protocol AppCoordinatorProtocol: ObservableObject {
    
    associatedtype NavigationEvent: Equatable
    associatedtype FullScreenCover
    associatedtype Screen
    associatedtype Sheet
    
    var path: NavigationPath { get set }
    var sheet: Sheet? { get set }
    var fullScreenCover: FullScreenCover? { get set }

    func handle(_ event: NavigationEvent)
}
