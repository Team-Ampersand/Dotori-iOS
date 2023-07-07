import BaseFeature
import Configure
import DesignSystem
import Localization
import MSGLayout
import UIKit

final class TimeHeaderView: BaseView {
    private let currentTimeLabel = UILabel()
        .set(\.text, L10n.Home.currentTimeTitle)
        .set(\.font, .dotori(.caption))
        .set(\.textColor, .dotori(.sub(.white)))
    private let dotoriHomeIcon = DotoriIconView(size: .custom(.init(width: 110, height: 110)))
        .set(\.image, .Dotori.dotoriHomeLogo)
    private let timerLabel = UILabel()
        .set(\.text, "오전 12: 59: 59")
        .set(\.font, .dotori(.h3))
        .set(\.textColor, .dotori(.sub(.white)))

    override func addView() {
        self.addSubviews {
            currentTimeLabel
            timerLabel
            dotoriHomeIcon
        }
    }

    override func setLayout() {
        MSGLayout.buildLayout {
            currentTimeLabel.layout
                .top(.toSuperview(), .equal(24))
                .leading(.toSuperview(), .equal(24))

            timerLabel.layout
                .top(.to(currentTimeLabel).bottom, .equal(4))
                .leading(.to(currentTimeLabel).leading)

            dotoriHomeIcon.layout
                .top(.toSuperview(), .equal(3))
                .trailing(.toSuperview(), .equal(24))
        }
    }

    override func configure() {
        self.layer.cornerRadius = 16
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        configureGradient()
    }
}

private extension TimeHeaderView {
    func configureGradient() {
        let gradient = CAGradientLayer()
        gradient.type = .radial
        gradient.colors = [
            UIColor(red: 0.34, green: 0.4, blue: 0.91, alpha: 1).cgColor,
            UIColor(red: 0.62, green: 0.35, blue: 0.96, alpha: 1).cgColor,
            UIColor(red: 0.78, green: 0.33, blue: 1, alpha: 1).cgColor
        ]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        let endY = 0.5 + self.frame.size.width / self.frame.size.height / 2
        gradient.locations = [0.6, 0.95, 1]
        gradient.endPoint = CGPoint(x: 1, y: endY)
        gradient.frame = self.bounds
        self.layer.insertSublayer(gradient, at: 0)
        self.layer.cornerRadius = 16
        self.clipsToBounds = true
    }
}
