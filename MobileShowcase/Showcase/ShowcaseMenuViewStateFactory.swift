import Layout

public
struct ShowcaseMenuViewStateFactory {
    func sections(for menu: MenuType) -> [ListSectionViewState] {
        switch menu {
        case .root:
            return root()
        case .effects:
            return effects()
        }
    }
    
    private func root() -> [ListSectionViewState] {
        [
            section(
                "mobile_showcase",
                item(.showScreen(.menu(.effects)), 0, "Effects"))
        ]
    }
    
    private func effects() -> [ListSectionViewState] {
        [
            section(
                "mobile_showcase_effects",
                item(.showScreen(.demo(.particleEffect)), 0, "Particle Effect"),
                item(.none, 1, "Other")),
        ]
    }
    
    private func section(
        _ id: String,
        _ items: MenuItemState...
    ) -> ListSectionViewState {
        section(id, items)
    }
    
    private func section(
        _ id: String,
        _ items: [MenuItemState]
    ) -> ListSectionViewState {
        ListSectionViewState(
            itemStore: ItemStore(items),
            title: "",
            id: id)
    }
    
    private func item(
        _ event: ShowcaseNavigationEvent,
        _ id: AnyHashable,
        _ title: String) -> MenuItemState {
        MenuItemState(event: event, id: id, title: title)
    }
}
