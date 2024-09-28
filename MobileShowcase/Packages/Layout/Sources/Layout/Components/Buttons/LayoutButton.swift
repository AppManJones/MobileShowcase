import SwiftUI

public
struct LayoutButton<Content: View>: View {
    var title: String?
    var image: Image?
    var style: LayoutButtonStyle
    var action: () -> Void
    var imageModifier: ((Image) -> Content)?

    private let padding: CGFloat = 12.0

    public init(
        title: String? = nil,
        image: Image? = nil,
        style: LayoutButtonStyle,
        action: @escaping () -> Void,
        imageModifier: ((Image) -> Content)? = nil  // Optional modifier
    ) {
        self.title = title
        self.image = image
        self.style = style
        self.action = action
        self.imageModifier = imageModifier
    }
    
    @ViewBuilder
    public var body: some View {
        Button(action: action) {
            HStack {
                if let image = image {
                    if let imageModifier = imageModifier {
                        imageModifier(image)
                    } else {
                        image
                    }
                }
                if let title = title {
                    Text(title)
                }
            }
            .padding(padding)
            .frame(maxWidth: .infinity)
        }
        .applyButtonStyle(style)
    }
}

extension View {
    @ViewBuilder
    func applyButtonStyle(_ style: LayoutButtonStyle) -> some View {
        switch style {
        case .primary:
            self.buttonStyle(PrimaryLayoutButtonStyle())
        case .secondary:
            self.buttonStyle(SecondaryLayoutButtonStyle())
        case .link:
            self.buttonStyle(LinkLayoutButtonStyle())
        case .bordered:
            self.buttonStyle(BorderedLayoutButtonStyle())
        }
    }
}
