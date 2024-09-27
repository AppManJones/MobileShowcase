import SwiftUI

struct UnderConstructionView: View {
    var body: some View {
        VStack {
            Spacer()
            Text("Under Construction")
                .foregroundStyle(.white)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
        .ignoresSafeArea()
    }
}
