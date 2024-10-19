@MainActor public
protocol Reducer {
    associatedtype DomainState: StateProtocol
    associatedtype ViewState: StateProtocol
    func reduce(_ domainState: DomainState, into viewState: ViewState) -> ViewState
}
