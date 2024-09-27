import Architecture
import SwiftUI

enum ASheet: Identifiable, Hashable {
    case none
    var id: Self { return self }
}

enum AFullScreenCover: Identifiable, Hashable {
    case none
    var id: Self { return self }
}

class MobileShowcaseAppCoordinator: AppCoordinatorProtocol {
    
    typealias NavigationEvent = ShowcaseNavigationEvent
    typealias Screen = ShowcaseScreen
    typealias Sheet = ASheet
    typealias FullScreenCover = AFullScreenCover
    
    @Published var path: NavigationPath = NavigationPath()
    @Published var sheet: Sheet?
    @Published var fullScreenCover: FullScreenCover?
    
    func handle(_ event: ShowcaseNavigationEvent) {
        switch event {
        case .showScreen(let menuType):
            push(menuType)
        case .showSheet(_):
            presentSheet(.none)
        case .showFullScreenCover(_):
            presentFullScreenCover(.none)
        case .none: break
        }
    }
    
    @ViewBuilder
    func build(_ screen: Screen) -> some View {
        switch screen {
        case .menu(let menuType):
            ShowcaseMenu(viewModel: ShowcaseMenuViewModel(menuType: menuType))
        case .demo:
            EmptyView()
        }
    }
    
    @ViewBuilder
    func build(_ sheet: Sheet) -> some View {
        switch sheet {
        case .none:
            EmptyView()
        }
    }
    
    @ViewBuilder
    func build(_ fullScreenCover: FullScreenCover) -> some View {
        switch fullScreenCover {
        case .none:
            EmptyView()
        }
    }
}

private
extension MobileShowcaseAppCoordinator {
    func push(_ screen: Screen) {
        path.append(screen)
    }
    
    func presentSheet(_ sheet: Sheet) {
        self.sheet = sheet
    }
    
    func presentFullScreenCover(_ fullScreenCover: FullScreenCover) {
        self.fullScreenCover = fullScreenCover
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    func dismissSheet() {
        self.sheet = nil
    }
    
    func dismissFullScreenOver() {
        self.fullScreenCover = nil
    }
}
