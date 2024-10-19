import Architecture
import SwiftUI

struct ArchitecturalDemoView<R: AppRouterProtocol, VM: ViewModel>: View
where VM.NavigationEvent == R.NavigationEvent {
    @EnvironmentObject var router: R
    
    @StateObject private var viewModel: VM
    
    init(
        _ viewModel: VM
    ) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        EmptyView()
            .onChange(of: viewModel.navigationEvent) { oldValue, newValue in
                if newValue != oldValue  {
                    handle(newValue)
                }
            }
    }
}

private
extension ArchitecturalDemoView {
    func handle(_ navigationEvent: R.NavigationEvent) {
        router.handle(navigationEvent)
    }
}
