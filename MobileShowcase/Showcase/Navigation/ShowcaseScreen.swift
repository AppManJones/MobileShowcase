enum ShowcaseScreen {
    case menu(MenuType)
    case demo(DemoType)
    var id: Self { return self }
}

extension ShowcaseScreen: Equatable, Hashable, Identifiable { }
