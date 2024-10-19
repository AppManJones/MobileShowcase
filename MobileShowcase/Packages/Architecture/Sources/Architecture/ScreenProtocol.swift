public
protocol ScreenProtocol: Equatable, Hashable, Identifiable {
    associatedtype Identifier: Hashable
    var id: Identifier { get }
    
}
