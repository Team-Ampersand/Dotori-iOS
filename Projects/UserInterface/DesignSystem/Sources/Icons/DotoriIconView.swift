import UIKit

public final class DotoriIconView: UIImageView {
    public enum IconSize: Equatable {
        case big
        case small
        case custom(CGSize)
    }

    @Invalidating(.layout) public var size: IconSize = .small

    public init(size: IconSize = .small) {
        self.size = size
        super.init(frame: .zero)
        setIconSize()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        setIconSize()
    }
}

private extension DotoriIconView {
    func setIconSize() {
        self.widthAnchor.constraint(equalToConstant: size.width).isActive = true
        self.heightAnchor.constraint(equalToConstant: size.height).isActive = true
    }
}

private extension DotoriIconView.IconSize {
    var width: CGFloat {
        switch self {
        case .big: return 32
        case .small: return 24
        case let .custom(size): return size.width
        }
    }

    var height: CGFloat {
        switch self {
        case .big: return 32
        case .small: return 24
        case let .custom(size): return size.height
        }
    }
}
