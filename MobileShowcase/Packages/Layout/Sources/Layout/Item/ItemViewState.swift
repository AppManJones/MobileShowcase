public protocol ItemViewState: Identifiable {
    var id: AnyHashable { get }
    func equals(_ state: Self) -> Bool
}

extension ItemViewState where Self: Equatable {
    public func equals(_ state: Self) -> Bool {
        return self.id == state.id
    }
}

public func ==<T: ItemViewState>(lhs: T, rhs: T) -> Bool {
    return lhs.id == rhs.id
}
