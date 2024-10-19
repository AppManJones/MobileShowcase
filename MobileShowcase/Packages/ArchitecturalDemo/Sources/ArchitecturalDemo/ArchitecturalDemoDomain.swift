import Architecture



enum ArchitecturalDemoDomainError: Error, Equatable {
    case fetchError(Error)
    case generic(Error)
    
    static func ==(lhs: ArchitecturalDemoDomainError, rhs: ArchitecturalDemoDomainError) -> Bool {
        switch (lhs, rhs) {
        case (.fetchError, .fetchError):
            return true
        case (.generic, .generic):
            return true
        default:
            return false
        }
    }
}

enum ArchitecturalDemoDomainAction: DomainActionProtocol {
    case fetch
    case select(index: Int)
}

struct ArchitecturalDemoDomainState: StateProtocol {
    let content: String
    let error: ArchitecturalDemoDomainError?
    init(
        content: String = "",
        error: ArchitecturalDemoDomainError? = nil
    ) {
        self.content = content
        self.error = error
    }
}

final
actor ArchitecturalDemoDomain: Domain {
    
    private let things = ["a", "b", "c", "d", "e", "f", ]
    private var currentIndex = 0
    
    func handle(_ action: ArchitecturalDemoDomainAction) async -> ArchitecturalDemoDomainState {
        switch action {
        case .fetch:
            do {
                return try await fetchContent()
            } catch {
                return ArchitecturalDemoDomainState(error: error as? ArchitecturalDemoDomainError)
            }
        case .select(let index):
            do {
                if index < things.count {
                    currentIndex = index
                }
                return try await update(things[currentIndex])
            } catch {
                return ArchitecturalDemoDomainState(error: error as? ArchitecturalDemoDomainError)
            }
        }
    }
}

private
extension ArchitecturalDemoDomain {
    func fetchContent() async throws -> ArchitecturalDemoDomainState {
        ArchitecturalDemoDomainState(content: things[currentIndex])
    }
    
    func update(_ content: String) async throws -> ArchitecturalDemoDomainState {
        ArchitecturalDemoDomainState(content: things[currentIndex])
    }
}
