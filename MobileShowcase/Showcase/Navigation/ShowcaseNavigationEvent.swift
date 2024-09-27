enum ShowcaseNavigationEvent: Equatable {
    case showScreen(ShowcaseScreen)
    case showSheet(ShowcaseScreen)
    case showFullScreenCover(ShowcaseScreen)
    case none
}
