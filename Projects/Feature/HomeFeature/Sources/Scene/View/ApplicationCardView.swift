import BaseFeature
import Combine
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
        .set(\.text, "10/50")
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
                .top(.toSuperview(), .equal(24))
                .leading(.toSuperview(), .equal(24))

            chevronRightButton.layout
                .top(.toSuperview(), .equal(24))
                .trailing(.toSuperview(), .equal(-24))

            applicationStatusLabel.layout
                .centerX(.toSuperview())
                .top(.to(titleLabel).bottom, .equal(16))

            applicationProgressView.layout
                .centerX(.toSuperview())
                .height(20)
                .top(.to(applicationStatusLabel).bottom, .equal(16))
                .horizontal(.toSuperview(), .equal(20))

            applyButton.layout
                .centerX(.toSuperview())
                .top(.to(applicationProgressView).bottom, .equal(16))
                .horizontal(.toSuperview(), .equal(20))
                .bottom(.toSuperview(), .equal(-24))
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

private extension ApplicationCardView {
    func configProgressViewCornerRadius() {
        let maskLayerPath = UIBezierPath(roundedRect: applicationProgressView.bounds, cornerRadius: 4)
        let maskLayer = CAShapeLayer()
        maskLayer.frame = applicationProgressView.bounds
        maskLayer.path = maskLayerPath.cgPath
        applicationProgressView.layer.mask = maskLayer
    }
}
