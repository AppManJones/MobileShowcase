import SwiftUI

/**
 `SprayParticle` represents an individual particle in an animation system. Each particle has a random initial offset and lifetime, which are used to control its movement, opacity, and rotation over time.

 The `SprayParticle` is designed to be used in particle-based animations where multiple particles are emitted and animated simultaneously. The particle's state (including its position, angle, and opacity) evolves over time, providing a smooth visual effect.

 ### Nested Types:
 - `Value`: A nested struct that encapsulates the particle's current state (angle, offset, opacity) at any given point in its animation.

 ### Properties:
 - `endOffset`: A `CGSize` value representing the final offset of the particle from its starting position. This determines how far the particle will travel over the course of its animation.
 - `lifeTime`: The total duration (in seconds) that the particle will remain active and visible. By default, this is set to 1.5 seconds.
 
 ### Behavior:
 - On initialization, a random angle and offset are generated for the particle. These values control the direction and distance the particle will move during its animation.
 - The `value(at:)` method computes the particle's current state (position, opacity, and rotation) based on a provided progress value, which is expected to range from 0 (start) to 1 (end).
 - The `draw(symbol:in:progress:)` method renders the particle at its current state using a provided `GraphicsContext` and resolved symbol.

 ### Usage:
 `SprayParticle` is typically used in conjunction with a `Canvas` or other drawing-based view to animate a collection of particles over time. The particle's position and appearance are updated incrementally, providing smooth movement, rotation, and fade effects.

 ### Example:
 To animate a collection of `SprayParticle` instances, use the `value(at:)` method to get the current state of each particle as its animation progresses. The particle can then be drawn using the `draw(symbol:in:progress:)` method.
 
 ```swift
 // Example usage in a drawing context
 let particle = SprayParticle()
 let progress: Double = 0.5 // Midpoint of the animation
 let particleState = particle.value(at: progress)
 ```
 
 // Use the particle's state (angle, offset, opacity) to draw it in the UI
 
 ### Performance Considerations:

 `SprayParticle` is designed to be used in high-performance animations with potentially large numbers of particles. It works well in a system where particles are updated and drawn frame-by-frame, making it suitable for complex effects like particle sprays, explosions, or other dynamic visuals.
 */
 struct SprayParticle {

    /// Contains properties to define the particle's current state.
    struct Value {
        var angle: Angle = .zero // The rotation angle of the particle.
        var offset: CGSize       // The offset from the origin.
        var opacity: CGFloat     // The opacity of the particle.
    }
    
    var endOffset: CGSize // The particle's final offset position.
    var lifeTime: TimeInterval = 1.5 // The lifetime of the particle.
    
    /// Initializes a new `SprayParticle` with a random angle and offset.
    init() {
        let angle = Angle.degrees(.random(in: 0..<360))
        let length = Double.random(in: 25..<100)
        self.endOffset = .init(width: cos(angle.radians) * length,
                               height: sin(angle.radians) * length)
    }
    
    /// Computes the current state of the particle based on its progress in the animation.
    /// - Parameter progress: A value between 0 and 1 indicating the progress of the animation.
    /// - Returns: The current `Value` of the particle.
    func value(at progress: Double) -> Value {
        let timeline = KeyframeTimeline(
            initialValue: Value(offset: .zero, opacity: 0)) {
                KeyframeTrack(\.offset) {
                    CubicKeyframe(endOffset, duration: 1) // Defines how the offset changes over time.
                }
                KeyframeTrack(\.opacity) {
                    CubicKeyframe(1, duration: 0.2)       // The particle fades in.
                    CubicKeyframe(0, duration: 0.8)       // The particle fades out.
                }
                KeyframeTrack(\.angle) {
                    CubicKeyframe(.zero, duration: 0.7)   // Rotation starts at zero.
                    CubicKeyframe(.degrees(45), duration: 0.3) // Particle rotates by 45 degrees.
                }
            }
        return timeline.value(progress: progress)
    }
    
    /// Draws the particle using a given symbol and context.
    /// - Parameters:
    ///   - symbol: The symbol to be drawn, representing the particle.
    ///   - context: The drawing context.
    ///   - progress: The current progress of the particle's animation.
    func draw(
        symbol: GraphicsContext.ResolvedSymbol,
        in context: inout GraphicsContext,
        progress: Double
    ) {
        let value = value(at: progress) // Get the current state of the particle.
        context.opacity = value.opacity
        context.translateBy(x: value.offset.width, y: value.offset.height)
        context.rotate(by: value.angle)
        context.draw(symbol, at: .zero) // Draws the particle at its updated position and state.
    }
}
