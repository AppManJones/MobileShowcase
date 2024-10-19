public
protocol Domain {
    associatedtype DomainAction: DomainActionProtocol
    associatedtype DomainState: StateProtocol
    func handle(_ action: DomainAction) async -> DomainState
}
