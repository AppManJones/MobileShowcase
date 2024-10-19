import Architecture

final
class ArchitecturalDemoReducer: Reducer {
    func reduce(_ domainState: ArchitecturalDemoDomainState, into viewState: ArchitecturalDemoViewState) -> ArchitecturalDemoViewState {
        ArchitecturalDemoViewState(content: domainState.content)
    }
}
