import Architecture
import Layout
import SwiftUI

struct ShowcaseMenu: View {

    @EnvironmentObject
    var appCoordinator: MobileShowcaseAppCoordinator
    
    @StateObject
    public var viewModel: ShowcaseMenuViewModel
    
    init(
        viewModel: ShowcaseMenuViewModel = ShowcaseMenuViewModel()
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        LayoutItemList(
            action: didSelectRow,
            factory: LayoutSystemViewFactor(),
            itemStore: viewModel.viewState.itemStore)
    }
}

private extension ShowcaseMenu {
    func didSelectRow(_ actionItem: Any) {
        guard let navigationEvent = actionItem as? ShowcaseNavigationEvent else { return }
        appCoordinator.handle(navigationEvent)
    }
}

#Preview {
    ShowcaseMenu()
}
