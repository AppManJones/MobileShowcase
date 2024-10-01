import SwiftUI

/// A modifier that adds a spray effect to a view, where particles are emitted and animated.
/**
 Performance Note: Transitioning from `ZStack` to `Canvas`.
 
 Originally, this particle effect was implemented using a `ZStack` to layer and animate particles over the content. However, when multiple instances of the effect were used simultaneously (e.g., across many images), performance degraded due to `ZStack`'s handling of view composition and layout. Transitioning to `Canvas` has significantly improved performance for the following reasons:
 
 - **`ZStack` Performance**:
   - **Pros**:
     - Ideal for layering a small number of views.
     - Works well with simple layouts and infrequent animations.
     - Easy to implement within SwiftUI's view hierarchy.
   - **Cons**:
     - Inefficient when handling many overlapping views, especially with animations.
     - Causes high CPU and memory usage due to constant recomposition of each view.
     - Poor scalability when adding dynamic, animated elements like particles.
 
 - **`Canvas` Performance**:
   - **Pros**:
     - Optimized for drawing large numbers of particles directly on the screen without going through SwiftUI’s view hierarchy.
     - Handles continuous animations and high particle counts more efficiently.
     - Reduces computational load by offloading work to the GPU, making particle effects smoother across many views.
   - **Cons**:
     - Requires more manual control over rendering, positions, and drawing contexts.
     - Lacks some built-in SwiftUI conveniences, such as transitions and automatic view animations.
 
 In this context, transitioning from `ZStack` to `Canvas` reduces memory overhead and improves animation performance, especially when there are many particle effects on the screen at the same time. `Canvas` is ideal for scenarios where complex drawing tasks or a large number of animated elements are involved.
 */
struct SprayEffect<T: Equatable>: ViewModifier {

    var trigger: T // A trigger to activate the spray effect.
    var numberOfParticles = 30 // The number of particles to emit.
    
    @State private var triggerDate: Date? = nil // The date when the trigger was last activated.
    @StateObject private var state = ParticleState() // Manages the state of the particles.
    
    /// Initializes a `SprayEffect` with a trigger and an optional number of particles.
    public init(
        trigger: T,
        numberOfParticles: Int = 30
    ) {
        self.trigger = trigger
        self.numberOfParticles = numberOfParticles
    }
    
    /// Defines the body of the view modifier.
    /// - Parameter content: The content view to which the spray effect is applied.
    /// - Returns: The modified view with the spray effect.
    func body(content: Content) -> some View {
        TimelineView(.animation(paused: state.isPaused)) { timelineContext in
            Canvas { context, size in
                // Resolves the symbol representing a particle.
                let symbol = context.resolveSymbol(id: "particle")!
                // Centers the context on the canvas.
                context.translateBy(x: size.width / 2, y: size.height / 2)
                
                // Draw each particle based on its start time and progress.
                for (particle, particleStart) in state.particles {
                    guard timelineContext.date >= particleStart else { continue }
                    
                    let diff = timelineContext.date.timeIntervalSince(particleStart)
                    let progress = diff / particle.lifeTime
                    guard progress < 1 else { continue }
                    
                    var copy = context
                    particle.draw(symbol: symbol, in: &copy, progress: progress)
                }
                
                // Removes particles that have completed their lifetime.
                state.particles.removeAll(where: {
                    $1.addingTimeInterval($0.lifeTime) <= timelineContext.date
                })
            } symbols: {
                // Uses the content as the particle symbol.
                content.tag("particle")
            }
            .frame(width: 200, height: 200) // Set the frame size for the canvas.
        }
        .onChange(of: trigger) {
            // When the trigger changes, reset the particles and start the animation.
            triggerDate = .now
            state.particles.append(contentsOf: (0..<numberOfParticles).map { _ in
                (particle: .init(),
                 startTime: .now.addingTimeInterval(.random(in: 0..<0.3)))
            })
        }
    }
}

public extension View {
    /// Applies the `SprayEffect` modifier to a view.
    /// - Parameters:
    ///   - trigger: A trigger value that controls when the spray effect starts.
    /// - Returns: The modified view with the spray effect applied.
    func sprayEffect<Trigger: Hashable>(trigger: Trigger) -> some View {
        self.background(
            self.modifier(SprayEffect(trigger: trigger))
        )
    }
}
