import UIKit

public final class DotoriIconView: UIImageView {
    public enum IconSize: CGFloat {
        case big = 32
        case small = 24
    }

    @Invalidating(.layout) public var size: IconSize = .small

    public init(size: IconSize = .small) {
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
        self.widthAnchor.constraint(equalToConstant: size.rawValue).isActive = true
        self.heightAnchor.constraint(equalToConstant: size.rawValue).isActive = true
    }
}
