import Layout
import Foundation

final
class ShowcaseMenuViewModel: ObservableObject {
    @Published var viewState: ShowcaseMenuViewState
    
    private let menuType: MenuType
    private let viewStateFactory: ShowcaseMenuViewStateFactory
    
    init(
        menuType: MenuType = .root,
        viewState: ShowcaseMenuViewState = ShowcaseMenuViewState(),
        viewStateFactory: ShowcaseMenuViewStateFactory = ShowcaseMenuViewStateFactory()
    ) {
        self.menuType = menuType
        self.viewState = viewState
        self.viewStateFactory = viewStateFactory
        createViewState()
    }
    
    private func createViewState() {
        let state = viewStateFactory.sections(for: menuType)
        self.viewState = ShowcaseMenuViewState(itemStore: ItemStore(state))
    }
}
