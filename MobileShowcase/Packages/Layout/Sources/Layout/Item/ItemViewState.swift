public protocol ItemViewState: Identifiable {
    var id: AnyHashable { get }
    func equals(_ state: Self) -> Bool
}

extension ItemViewState where Self: Equatable {
    public func equals(_ state: Self) -> Bool {
        self == state
    }
}
