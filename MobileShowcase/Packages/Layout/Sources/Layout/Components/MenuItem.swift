import SwiftUI

public
struct MenuItem: LayoutItem {
    let action: ItemAction
    public let viewState: MenuItemState
    
    public init(
        action: @escaping ItemAction,
        viewState: MenuItemState
    ) {
        self.action = action
        self.viewState = viewState
    }
    
    public var body: some View {
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

public
struct MenuItemState: ItemViewState, Equatable {
    let event: Any
    public let id: AnyHashable
    let title: String
    
    public init(
        event: Any,
        id: AnyHashable,
        title: String
    ) {
        self.event = event
        self.id = id
        self.title = title
    }
}
