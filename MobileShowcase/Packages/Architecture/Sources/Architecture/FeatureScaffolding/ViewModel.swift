import Combine

@MainActor public
protocol ViewModel: ObservableObject {
    associatedtype DomainType
    associatedtype ReducerType
    associatedtype ViewEvent: ViewEventProtocol
    associatedtype ViewState: StateProtocol
    associatedtype NavigationEvent: NavigationEventProtocol
    
    var domain: DomainType { get }
    var reducer: ReducerType { get }
    var viewState: ViewState { get }
    var navigationEvent: NavigationEvent { get }
    
    init(domain: DomainType, reducer: ReducerType, viewState: ViewState)

    func handle(_ viewEvent: ViewEvent) async
}
