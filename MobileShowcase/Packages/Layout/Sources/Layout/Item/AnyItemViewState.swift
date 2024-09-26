public struct AnyItemViewState: Identifiable, ItemViewState {
    private let _id: () -> AnyHashable
    private let _equals: (Any) -> Bool
    public let viewState: any ItemViewState

    public init<T: ItemViewState>(_ base: T) {
        self.viewState = base
        self._id = { base.id }
        self._equals = { ($0 as? T)?.equals(base) ?? false }
    }

    public var id: AnyHashable {
        _id()
    }

    public func equals(_ other: AnyItemViewState) -> Bool {
        _equals(other.viewState)
    }

    public func equals(_ state: any ItemViewState) -> Bool {
        guard let other = state as? Self else { return false }
        return self.equals(other)
    }
}
