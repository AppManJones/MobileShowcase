import Layout
import SwiftUI

struct ParticleEffectDemoView: View {
    var body: some View {
        VStack {
            Spacer()
            Text("Particle Effect")
                .foregroundStyle(.white)
            LayoutButton(
                title: "Press",
                image: Image(systemName: "star"),
                style: .primary,
                action: didTap
            )
            .padding()
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
        .ignoresSafeArea()
    }
}

private extension ParticleEffectDemoView {
    func didTap() {
        print("Primary button tapped")
    }
}
