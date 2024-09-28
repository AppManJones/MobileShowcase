import Layout
import SwiftUI

struct ParticleEffectDemoView: View {
    @State private var trigger = 0
    var body: some View {
        VStack {
            Spacer()
            Text("Particle Effect")
                .foregroundStyle(.white)
            LayoutButton(
                title: "Press",
                image: Image(systemName: "star.fill"),
                style: .secondary,
                action: didTap,
                imageModifier: { image in
                    image.sprayEffect(trigger: trigger)
                }
            )
            .padding()
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.white)
        .ignoresSafeArea()
    }
}

private extension ParticleEffectDemoView {
    func didTap() {
        trigger += 1
    }
}
