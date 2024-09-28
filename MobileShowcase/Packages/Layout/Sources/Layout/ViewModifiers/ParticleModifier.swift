import SwiftUI

public
struct ParticleModifier<Trigger: Hashable>: ViewModifier {
    
    var trigger: Trigger
    
    var offset: CGSize {
        .init(width: 50, height: 30)
    }
    
    var t: AnyTransition {
        .asymmetric(
            insertion: .identity,
            removal:
                    .offset(offset)
                    .combined(with: .opacity)
        )
    }
    
    public func body(content: Content) -> some View {
        ZStack {
            content
                .transition(t)
                .id(trigger)
                .animation(.default, value: trigger)
        }
    }
}

public
extension View {
    func sprayEffect<Trigger: Hashable>(trigger: Trigger) -> some View {
        self.background(
            ZStack {
                ForEach(0..<30) { _ in
                    self
                        .modifier(ParticleModifier(trigger: trigger))
                }
            }
        )
    }
}
