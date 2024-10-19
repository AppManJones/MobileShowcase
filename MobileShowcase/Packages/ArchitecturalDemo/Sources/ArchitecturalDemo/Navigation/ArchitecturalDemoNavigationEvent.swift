import Architecture

enum MyFullScreenCover: ScreenProtocol {
    case none
    var id: Self { return self }
}

enum MySheet: ScreenProtocol {
    case none
    var id: Self { return self }
}

enum SampleScreen: ScreenProtocol {
    case pageOne
    case pageTwo
    var id: Self { return self }
}

enum NavigationEvent: NavigationEventProtocol {
    case showScreen(SampleScreen)
    case showSheet(SampleScreen)
    case showFullScreenCover(SampleScreen)
    case none
}
