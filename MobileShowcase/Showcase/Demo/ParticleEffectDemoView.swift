import Layout
import SwiftUI

struct ParticleEffectDemoView: View {
    @State private var trigger = 0
    var body: some View {
        VStack {
            Spacer()
            Text("Particle Effect")
                .foregroundStyle(.white)

            LayoutIconButton(
                image: Image(systemName: "star.fill")
                    .sprayEffect(trigger: trigger),
                action: didTap
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
