import Layout

struct ShowcaseMenuViewState {
    let itemStore: ItemStore
    public init(itemStore: ItemStore = ItemStore(items: [])) {
        self.itemStore = itemStore
    }
}
