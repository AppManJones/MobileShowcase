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

struct SprayEffectModifier<T: Equatable>: ViewModifier {

    var trigger: T
    var numberOfParticles = 30
    var duration: TimeInterval = 0.5
    
    @State private var startData: Date? = nil
    @State private var angles: [Angle] = []
    
    func body(content: Content) -> some View {
        TimelineView(.animation(paused: startData == nil)) { timelineContext in
            Canvas { context, size in
                guard let startData else { return }
                let diff = timelineContext.date.timeIntervalSince(startData)
                let symbol = context.resolveSymbol(id: "particle")!
                context.translateBy(x: size.width / 2 , y: size.height / 2)
                
                let progress = diff / duration
                guard progress < 1 else { return }
                context.opacity = 1 - progress
                
                for angle in angles {
                    let x = cos(angle.radians) * 50 * diff
                    let y = sin(angle.radians) * 50 * diff
                    let offset = CGPoint(x: x, y: y)
                    context.draw(symbol, at: offset)
                }
            } symbols: {
                content.tag("particle")
            }
                .frame(width: 200, height: 200)
        }
        .onChange(of: trigger) {
            startData = .now
            angles = (0..<numberOfParticles).map { _ in .degrees(.random(in: 0..<360)) }
        }
    }
}

public
extension View {
    func sprayEffect<Trigger: Hashable>(trigger: Trigger) -> some View {
        self.background(
            self.modifier(SprayEffectModifier(trigger: trigger))
        )
    }
}
