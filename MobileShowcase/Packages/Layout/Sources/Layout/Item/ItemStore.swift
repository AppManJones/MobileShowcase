public struct ItemStore {
    public var items: [AnyItemViewState] = []

    public init(
        items: [AnyItemViewState] = []
    ) {
        self.items = items
    }

    public init(
        sections: [ItemSection] = []
    ) {
        self.items = sections.flatMap(\.items).map { AnyItemViewState($0) }
    }
    
    public init(
        _ itemViewStates: [any ItemViewState]
    ) {
        self.items = itemViewStates.map { AnyItemViewState($0) }
    }
}
