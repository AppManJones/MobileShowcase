import Architecture
import SwiftUI

final
class ArchitecturalDemoAppRouter: AppRouterProtocol {
        
    @Published var path: NavigationPath = NavigationPath()
    @Published var sheet: SampleScreen?
    @Published var fullScreenCover: SampleScreen?
    
    func handle(_ event: NavigationEvent) {
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
    func build(_ screen: SampleScreen) -> some View {
        switch screen {
        case .menu:
            EmptyView()
        case .demo:
            EmptyView()
        }
    }
}

private
extension ArchitecturalDemoAppRouter {
    func push(_ screen: SampleScreen) {
        path.append(screen)
    }
    
    func presentSheet(_ sheet: SampleScreen) {
        self.sheet = sheet
    }
    
    func presentFullScreenCover(_ fullScreenCover: SampleScreen) {
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
