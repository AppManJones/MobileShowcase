import Layout
import SwiftUI

struct TableOfContentsItem: LayoutItem {
    let action: ItemAction
    let viewState: TableOfContentsItemState
    
    init(
        action: @escaping ItemAction,
        viewState: TableOfContentsItemState
    ) {
        self.action = action
        self.viewState = viewState
    }
    
    var body: some View {
        HStack {
            Text(viewState.title)
            Spacer()
        }
        .contentShape(Rectangle())
        .onTapGesture {
            action(viewState.event)
        }
    }
}

struct TableOfContentsItemState: ItemViewState, Equatable {
    let event: TableOfContentsNavigationEvent
    let id: AnyHashable
    let title: String
    
    init(
        event: TableOfContentsNavigationEvent,
        id: AnyHashable,
        title: String
    ) {
        self.event = event
        self.id = id
        self.title = title
    }
}
