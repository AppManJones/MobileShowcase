import SwiftUI

extension Animatable {
    static func *(lhs: Self, rhs: Double) -> Self {
        var copy = lhs
        copy.animatableData.scale(by: rhs)
        return copy
    }
}

extension AnyTransition {
    static func keyframe(offset: CGSize) -> AnyTransition {
        modifier(active: KeyframeModifer(endOffset: offset, progress: 1),
                 identity: KeyframeModifer(endOffset: offset, progress: 0))
    }
}

public
struct KeyframeModifer: ViewModifier, @preconcurrency Animatable {
    
    var endOffset: CGSize
    var progress: Double
    
    public var animatableData: Double {
        get { progress }
        set { progress = newValue }
    }
    
    struct Value {
        var angle: Angle = .zero
        var offset: CGSize
        var opacity: CGFloat
    }
    
    public func body(content: Content) -> some View {
        let timeline = KeyframeTimeline(
            initialValue: Value(offset: .zero, opacity: 0)) {
                KeyframeTrack(\.offset) {
                    CubicKeyframe(endOffset * 0.5, duration: 0.3)
                    CubicKeyframe(endOffset * 0.2, duration: 0.2)
                    CubicKeyframe(endOffset, duration: 0.5)
                }
                KeyframeTrack(\.opacity) {
                    CubicKeyframe(1, duration: 0.2)
                    CubicKeyframe(0, duration: 0.8)
                }
                KeyframeTrack(\.angle) {
                    CubicKeyframe(.degrees(360), duration: 0.7)
                }
            }
        let value = timeline.value(progress: progress)
        content
            .rotationEffect(value.angle)
            .offset(value.offset)
            .opacity(value.opacity)
    }
}

public
struct ParticleModifier<Trigger: Hashable>: ViewModifier {
    
    var trigger: Trigger
    
    @State var angle = Angle.degrees(.random(in: 0...360))
    
    @State var distance: Double = .random(in: 10...50)
    
    var offset: CGSize {
        .init(
            width: cos(angle.radians) * distance,
            height: sin(angle.radians) * distance)
    }
    
    var t: AnyTransition {
        .asymmetric(
            insertion: .identity,
            removal: .keyframe(offset: offset)
        )
    }
    
    public func body(content: Content) -> some View {
        ZStack {
            content
                .transition(t)
                .id(trigger)
        }
        .animation(.default.speed(0.1), value: trigger)
        .onChange(of: trigger) {
            angle = Angle.degrees(.random(in: 0...360))
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
