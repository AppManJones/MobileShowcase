import Architecture

enum ShowcaseScreen: ScreenProtocol {
    case menu(MenuType)
    case demo(DemoType)
    var id: Self { return self }
}
