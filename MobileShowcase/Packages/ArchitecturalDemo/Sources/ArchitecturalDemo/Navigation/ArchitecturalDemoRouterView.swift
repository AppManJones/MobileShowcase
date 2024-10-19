import Architecture
import SwiftUI

struct ArchitecturalDemoRouterView<Coordinator: AppRouterProtocol>: View {
    
    @StateObject
    public var router: ArchitecturalDemoAppRouter
    
    init(
        router: ArchitecturalDemoAppRouter = ArchitecturalDemoAppRouter()
    ) {
        _router = StateObject(wrappedValue: router)
    }
    
    var body: some View {
        NavigationStack(path: $router.path) {
            router.build(.pageOne)
                .navigationDestination(for: ArchitecturalDemoAppRouter.Screen.self) { screen in
                    router.build(screen)
                        .environmentObject(router)
                }
                .sheet(item: $router.sheet) { sheet in
                    router.build(sheet)
                        .environmentObject(router)
                }
                .fullScreenCover(item: $router.fullScreenCover) { fullScreenCover in
                    router.build(fullScreenCover)
                        .environmentObject(router)
                }
        }
        .environmentObject(router)
    }
}
