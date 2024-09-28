import SwiftUI

struct IconButton: View {
    var image: Image
    var action: () -> Void

    private let padding: CGFloat = 12.0

    var body: some View {
        Button(action: action) {
            image
                .padding(padding)
        }
        .buttonStyle(BorderlessButtonStyle())
    }
}
