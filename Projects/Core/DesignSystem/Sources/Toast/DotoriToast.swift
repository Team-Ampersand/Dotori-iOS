import UIKit

public final class DotoriToast: UIView {
    public enum Duration: Double {
        case short = 1.5
        case long = 3
    }

    public enum Style {
        case success
        case warning
        case error
    }

    private enum Dimension {
        // swiftlint: disable nesting
        enum Margin {
            static let horizontal: CGFloat = 16
            static let vertical: CGFloat = 66
        }

        enum Padding {
            static let horizontal: CGFloat = 24
            static let vertical: CGFloat = 28
        }

        static let viewSpacing: CGFloat = 12
    }

    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .dotori(.neutral(.n10))
        label.numberOfLines = 0
        return label
    }()
    private let iconView: DotoriIconView = DotoriIconView()
    private var text: String? {
        get { label.text }
        set { label.text = newValue }
    }
    private let color: UIColor
    private let duration: Duration

    private init(
        text: String?,
        style: DotoriToast.Style,
        duration: DotoriToast.Duration
    ) {
        self.color = style.color
        self.duration = duration
        super.init(frame: .zero)
        self.text = text
        self.label.textColor = style.color
        self.iconView.image = UIImage(systemName: style.systemName)
        self.iconView.tintColor = style.color
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public static func makeToast(
        text: String?,
        style: DotoriToast.Style,
        duration: DotoriToast.Duration = .short
    ) {
        guard let text, !text.isEmpty else { return }
        let toast = DotoriToast(
            text: text,
            style: style,
            duration: duration
        )

        guard let window = UIApplication.currentWindow() else { return }
        window.addSubview(toast)
        toast.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            toast.topAnchor.constraint(
                equalTo: window.safeAreaLayoutGuide.topAnchor,
                constant: -8
            ),
            toast.leadingAnchor.constraint(
                equalTo: window.leadingAnchor,
                constant: Dimension.Margin.horizontal
            ),
            toast.trailingAnchor.constraint(
                equalTo: window.trailingAnchor,
                constant: -Dimension.Margin.horizontal
            )
        ])
        toast.showToast()
    }

    private func showToast() {
        UIView.animate(
            withDuration: 0.5,
            delay: 0.0,
            options: .curveEaseIn,
            animations: {
                let topTansform = CGAffineTransform(translationX: 0.0, y: 16.0)
                self.transform = topTansform
                self.alpha = 1.0
            }, completion: { _ in
                self.hideToastAfterDuration()
            }
        )
    }

    private func hideToastAfterDuration() {
        UIView.animate(
            withDuration: 0.5,
            delay: self.duration.rawValue,
            options: .curveEaseOut,
            animations: {
                let bottomTansform = CGAffineTransform(translationX: 0.0, y: 0.0)
                self.transform = bottomTansform
                self.alpha = 0.0
            }, completion: { _ in
                self.removeFromSuperview()
            }
        )
    }
}

private extension DotoriToast {
    func setupView() {
        self.addSubview(label)
        self.addSubview(iconView)
        setLayout()
        self.backgroundColor = .dotori(.background(.bg))
        self.layer.cornerRadius = 8
        self.alpha = 0
        DotoriShadow.toastShadow(toast: self)
    }

    func setLayout() {
        label.translatesAutoresizingMaskIntoConstraints = false
        iconView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            iconView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            iconView.leadingAnchor.constraint(
                equalTo: self.leadingAnchor,
                constant: Dimension.Padding.horizontal
            ),

            label.leadingAnchor.constraint(
                equalTo: iconView.trailingAnchor,
                constant: Dimension.viewSpacing
            ),
            label.heightAnchor.constraint(
                equalTo: self.heightAnchor,
                constant: -Dimension.Padding.vertical
            ),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}

private extension DotoriToast.Style {
    var color: UIColor {
        switch self {
        case .success: return .dotori(.system(.positive))
        case .warning: return .dotori(.system(.error))
        case .error: return .dotori(.sub(.yellow))
        }
    }

    var systemName: String {
        switch self {
        case .success: return "checkmark.circle.fill"
        case .warning: return "exclamationmark.triangle.fill"
        case .error: return "exclamationmark.circle.fill"
        }
    }
}
