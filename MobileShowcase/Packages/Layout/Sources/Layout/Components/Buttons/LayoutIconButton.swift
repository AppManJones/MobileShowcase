import SwiftUI

public
struct LayoutIconButton<Content: View>: View {
    let action: () -> Void
    let image: Content

    private let padding: CGFloat = 12.0

    public init(
        image: Content,
        action: @escaping () -> Void
    ) {
        self.image = image
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            image
                .padding(padding)
        }
        .buttonStyle(BorderlessButtonStyle())
    }
}
