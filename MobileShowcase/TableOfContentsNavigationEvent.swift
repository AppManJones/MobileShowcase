enum TableOfContentsNavigationEvent: Equatable {
    case push(TableOfContentsMenu)
    case presentContent
    case none
}
