import Layout

public
struct TableOfContentsViewStateFactory {
    func sections(for menu: TableOfContentsMenu) -> [TableOfContentsSectionState] {
        switch menu {
        case .root:
            return root()
        }
    }
    
    private func root() -> [TableOfContentsSectionState] {
        [
            section(
                "section_1",
                item(.none, 0, "1 - 1"),
                item(.none, 1, "1 - 2")),
            section(
                "section_2",
                item(.none, 2, "2 - 1"),
                item(.none, 3, "2 - 2"),
                item(.none, 4, "2 - 3"))
        ]
    }
    
    private func section(
        _ id: String,
        _ items: TableOfContentsItemState...
    ) -> TableOfContentsSectionState {
        section(id, items)
    }
    
    private func section(
        _ id: String,
        _ items: [TableOfContentsItemState]
    ) -> TableOfContentsSectionState {
        TableOfContentsSectionState(
            itemStore: ItemStore(items),
            title: "",
            id: id)
    }
    
    private func item(
        _ event: TableOfContentsNavigationEvent,
        _ id: AnyHashable,
        _ title: String) -> TableOfContentsItemState {
        TableOfContentsItemState(event: event, id: id, title: title)
    }
}
