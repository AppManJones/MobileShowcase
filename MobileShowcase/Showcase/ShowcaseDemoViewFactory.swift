import SwiftUI

struct ShowcaseDemoViewFactory {
    @ViewBuilder
    func build(for demoType: DemoType) -> some View {
        switch demoType {
        case .particleEffect:
            ParticleEffectDemoView()
        case .underConstruction:
            UnderConstructionView()
        }
    }
}
