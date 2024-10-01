import Foundation

/**
 `ParticleState` is a class responsible for managing the state of particle animations. It uses Swift's `ObservableObject` to notify views when changes occur and ensures that the state is updated safely on the main thread by leveraging `@MainActor`.

 This class maintains a collection of particles and their start times, and it also manages whether the particle animation is currently paused or active based on the presence of particles.

 ### Properties:
 - `isPaused`: A `Bool` that controls whether the particle animation is paused. It is `true` when no particles are present and `false` when particles are actively animating.
 - `particles`: A list of `SprayParticle` objects along with their associated start times. The list is updated dynamically as particles are added or removed, and this automatically triggers a pause or resume of the animation based on whether the list is empty.

 ### Behavior:
 - When particles are added or removed, the `isPaused` property is updated on the main thread. If the particle collection becomes empty, `isPaused` is set to `true`, pausing the animation. If particles are present, `isPaused` is set to `false`, resuming the animation.
 
 ### Thread Safety:
 - This class is annotated with `@MainActor`, ensuring that all state updates, including changes to `particles` and `isPaused`, are performed on the main thread. This eliminates the need for manual thread management when updating state in SwiftUI views.
 
 ### Usage:
 - This class is typically used in conjunction with a view modifier or a SwiftUI view that animates particles. It allows views to observe the state of particles and update the user interface accordingly, ensuring smooth animations that are properly synchronized with the app's main thread.
 */
@MainActor
final class ParticleState: ObservableObject {
    @Published var isPaused: Bool = true // Controls whether the particle animation is paused.
    
    /// Stores a collection of particles and their start times.
    var particles: [(particle: SprayParticle, startTime: Date)] = [] {
        didSet {
            // When particles are added or removed, update the `isPaused` property.
            DispatchQueue.main.async {
                if oldValue.isEmpty != self.particles.isEmpty {
                    self.isPaused = self.particles.isEmpty
                }
            }
        }
    }
}
