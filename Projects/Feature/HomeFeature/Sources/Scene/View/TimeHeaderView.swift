import BaseFeature
import Configure
import DateUtility
import DesignSystem
import Localization
import MSGLayout
import UIKit

final class TimeHeaderView: BaseView {
    private enum Metric {
        static let padding: CGFloat = 24
    }

    private let currentTimeLabel = DotoriLabel(
        L10n.Home.currentTimeTitle,
        textColor: .sub(.white),
        font: .caption
    )
    private let dotoriHomeIcon = DotoriIconView(
        size: .custom(.init(width: 110, height: 110)),
        image: .Dotori.dotoriHomeLogo
    )
    private let timerLabel = DotoriLabel("AM 00: 00: 00", textColor: .sub(.white), font: .h3)

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
                .top(.toSuperview(), .equal(Metric.padding))
                .leading(.toSuperview(), .equal(Metric.padding))

            timerLabel.layout
                .top(.to(currentTimeLabel).bottom, .equal(4))
                .leading(.to(currentTimeLabel).leading)
                .bottom(.toSuperview(), .equal(-Metric.padding))

            dotoriHomeIcon.layout
                .top(.toSuperview(), .equal(7))
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

    public func updateTime(time: Date) {
        timerLabel.text = time.toStringWithCustomFormat("a HH:mm:ss")
    }
}

private extension TimeHeaderView {
    func configureGradient() {
        let gradientColors = [
            UIColor(red: 0.34, green: 0.4, blue: 0.91, alpha: 1).cgColor,
            UIColor(red: 0.62, green: 0.35, blue: 0.96, alpha: 1).cgColor,
            UIColor(red: 0.78, green: 0.33, blue: 1, alpha: 1).cgColor
        ]
        let endY = 0.5 + self.frame.size.width / self.frame.size.height / 2
        let gradient = CAGradientLayer()
            .set(\.type, .radial)
            .set(\.colors, gradientColors)
            .set(\.startPoint, CGPoint(x: 0, y: 0))
            .set(\.locations, [0.6, 0.95, 1.0])
            .set(\.endPoint, CGPoint(x: 1, y: endY))
            .set(\.frame, self.bounds)
        self.layer.insertSublayer(gradient, at: 0)
        self.layer.cornerRadius = 16
        self.clipsToBounds = true
    }
}
