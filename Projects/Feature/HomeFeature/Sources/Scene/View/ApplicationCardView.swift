import BaseFeature
import Combine
import CombineUtility
import Configure
import DesignSystem
import Localization
import MSGLayout
import UIKit

protocol ApplicationCardViewActionProtocol {
    var applyButtonDidTapPublisher: AnyPublisher<Void, Never> { get }
    var detailButtonDidTapPublisher: AnyPublisher<Void, Never> { get }
}

final class ApplicationCardView: BaseView {
    private enum Metric {
        static let padding: CGFloat = 16
        static let spacing: CGFloat = 16
    }
    private let titleLabel = UILabel()
        .set(\.font, .dotori(.subtitle2))
        .set(\.textColor, .dotori(.neutral(.n10)))
    private let chevronRightButton = UIButton()
        .then {
            $0.titleLabel?.font = .dotori(.caption)
            $0.setTitleColor(.dotori(.neutral(.n20)), for: .normal)
            $0.setTitle(">", for: .normal)
        }
    private let applicationStatusLabel = UILabel()
        .set(\.text, "0/0")
        .set(\.font, .dotori(.h2))
        .set(\.textColor, .dotori(.neutral(.n10)))
    private let applicationProgressView = UIProgressView()
    private let applyButton = DotoriButton()

    init(
        title: String,
        applyText: String,
        maxApplyCount: Int
    ) {
        super.init()
        self.titleLabel.text = title
        self.applyButton.setTitle(applyText, for: .normal)
        self.applicationStatusLabel.text = "0/\(maxApplyCount)"
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func addView() {
        self.addSubviews {
            titleLabel
            chevronRightButton
            applicationStatusLabel
            applicationProgressView
            applyButton
        }
    }

    override func setLayout() {
        MSGLayout.buildLayout {
            titleLabel.layout
                .top(.toSuperview(), .equal(Metric.padding))
                .leading(.toSuperview(), .equal(Metric.padding))

            chevronRightButton.layout
                .top(.toSuperview(), .equal(Metric.padding))
                .trailing(.toSuperview(), .equal(-Metric.padding))

            applicationStatusLabel.layout
                .centerX(.toSuperview())
                .top(.to(titleLabel).bottom, .equal(Metric.spacing))

            applicationProgressView.layout
                .centerX(.toSuperview())
                .height(20)
                .top(.to(applicationStatusLabel).bottom, .equal(Metric.spacing))
                .horizontal(.toSuperview(), .equal(Metric.padding))

            applyButton.layout
                .centerX(.toSuperview())
                .top(.to(applicationProgressView).bottom, .equal(Metric.spacing))
                .horizontal(.toSuperview(), .equal(Metric.padding))
                .bottom(.toSuperview(), .equal(-Metric.padding))
        }
    }

    override func configure() {
        self.backgroundColor = .dotori(.background(.card))
        self.layer.cornerRadius = 16
        DotoriShadow.cardShadow(card: self)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        configProgressViewCornerRadius()
    }
}

extension ApplicationCardView: ApplicationCardViewActionProtocol {
    var applyButtonDidTapPublisher: AnyPublisher<Void, Never> {
        applyButton.tapPublisher
    }

    var detailButtonDidTapPublisher: AnyPublisher<Void, Never> {
        chevronRightButton.tapPublisher
    }
}

private extension ApplicationCardView {
    func configProgressViewCornerRadius() {
        let maskLayerPath = UIBezierPath(roundedRect: applicationProgressView.bounds, cornerRadius: 4)
        let maskLayer = CAShapeLayer()
        maskLayer.frame = applicationProgressView.bounds
        maskLayer.path = maskLayerPath.cgPath
        applicationProgressView.layer.mask = maskLayer
    }
}
