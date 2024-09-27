enum ShowcaseNavigationEvent: Equatable {
    case showScreen(ShowcaseScreen)
    case showSheet(ShowcaseSheet)
    case showFullScreenCover(ShowcaseFullScreenCover)
    case none
}
