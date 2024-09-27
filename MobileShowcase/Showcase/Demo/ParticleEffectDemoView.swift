import SwiftUI

struct ParticleEffectDemoView: View {
    var body: some View {
        VStack {
            Spacer()
            Text("Particle Effect")
                .foregroundStyle(.white)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
        .ignoresSafeArea()
    }
}
