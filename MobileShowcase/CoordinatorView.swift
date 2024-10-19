import Architecture
import SwiftUI

struct CoordinatorView: View {
    
    @StateObject
    public var appCoordinator: MobileShowcaseAppRouter
    
    init(
        appCoordinator: MobileShowcaseAppRouter = MobileShowcaseAppRouter()
    ) {
        _appCoordinator = StateObject(wrappedValue: appCoordinator)
    }
    
    var body: some View {
        NavigationStack(path: $appCoordinator.path) {
            appCoordinator.build(.menu(.root))
                .navigationDestination(for: MobileShowcaseAppRouter.Screen.self) { screen in
                    appCoordinator.build(screen)
                }
                .sheet(item: $appCoordinator.sheet) { sheet in
                    appCoordinator.build(sheet)
                }
                .fullScreenCover(item: $appCoordinator.fullScreenCover) { fullScreenCover in
                    appCoordinator.build(fullScreenCover)
                }
        }
        .environmentObject(appCoordinator)
    }
}
