import Architecture
import SwiftUI

final class MobileShowcaseAppCoordinator: AppCoordinatorProtocol {

    @Published var path: NavigationPath = NavigationPath()
    @Published var sheet: ShowcaseScreen?
    @Published var fullScreenCover: ShowcaseScreen?

    func handle(_ event: ShowcaseNavigationEvent) {
        switch event {
        case .showScreen(let screen):
            push(screen)
        case .showSheet(let sheet):
            presentSheet(sheet)
        case .showFullScreenCover(let cover):
            presentFullScreenCover(cover)
        case .none: break
        }
    }
    
    @ViewBuilder
    func build(_ screen: ShowcaseScreen) -> some View {
        switch screen {
        case .menu(let menuType):
            ShowcaseMenu(viewModel: ShowcaseMenuViewModel(menuType: menuType))
        case .demo(let demoType):
            ShowcaseDemoViewFactory().build(for: demoType)
        }
    }

    @ViewBuilder
    func buildSheet(_ sheet: ShowcaseSheet) -> some View {
        switch sheet {
        case .none:
            Text("Menu Sheet - None")
        }
    }

    @ViewBuilder
    func buildFullScreenCover(_ fullScreenCover: ShowcaseFullScreenCover) -> some View {
        switch fullScreenCover {
        case .none:
            Text("Full Screen Cover - None")
        }
    }
}

private
extension MobileShowcaseAppCoordinator {
    func push(_ screen: ShowcaseScreen) {
        path.append(screen)
    }
    
    func presentSheet(_ sheet: ShowcaseScreen) {
        self.sheet = sheet
    }
    
    func presentFullScreenCover(_ fullScreenCover: ShowcaseScreen) {
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
