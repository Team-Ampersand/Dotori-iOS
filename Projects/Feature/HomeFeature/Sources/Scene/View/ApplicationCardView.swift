import BaseFeature
import Combine
import CombineUtility
import Configure
import DesignSystem
import GlobalThirdPartyLibrary
import Localization
import MSGLayout
import UIKit

protocol ApplicationCardViewStateProtocol {
    var isLoading: Bool { get }
    var buttonTitle: String { get }
    var buttonIsEnabled: Bool { get }
}
protocol ApplicationCardViewActionProtocol {
    var applyButtonDidTapPublisher: AnyPublisher<Void, Never> { get }
    var detailButtonDidTapPublisher: AnyPublisher<Void, Never> { get }
}

final class ApplicationCardView: BaseView {
    private enum Metric {
        static let padding: CGFloat = 24
        static let spacing: CGFloat = 16
    }
    private let titleLabel = DotoriLabel()
    private let loadingIndicatorView = UIActivityIndicatorView(style: .medium)
    private let chevronRightButton = DotoriTextButton(
        ">",
        textColor: .neutral(.n20),
        font: .caption
    )
    private lazy var headerStackView = HStackView(spacing: 8) {
        titleLabel
        loadingIndicatorView
        SpacerView()
        chevronRightButton
    }
    private let applicationStatusLabel = DotoriLabel(font: .h2)
    private let applicationProgressView = UIProgressView()
        .set(\.cornerRadius, 8)
        .set(\.clipsToBounds, true)
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
            headerStackView
            applicationStatusLabel
            applicationProgressView
            applyButton
        }
    }

    override func setLayout() {
        MSGLayout.buildLayout {
            headerStackView.layout
                .top(.toSuperview(), .equal(Metric.padding))
                .horizontal(.toSuperview(), .equal(Metric.padding))

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
    }

    public func updateApplyCount(current: Int, max: Int) {
        let newProgress = Float(current) / Float(max)

        UIView.animate(withDuration: 0.4) {
            self.applicationProgressView.setProgress(newProgress, animated: true)
            self.applicationProgressView.progressTintColor = self.toBarColor(current: current, max: max)
        }

        self.applicationStatusLabel.text = "\(current)/\(max)"
    }
}

extension ApplicationCardView: ApplicationCardViewStateProtocol {
    var isLoading: Bool {
        get { loadingIndicatorView.isAnimating }
        set {
            newValue ?
            loadingIndicatorView.startAnimating() :
            loadingIndicatorView.stopAnimating()
        }
    }

    var buttonTitle: String {
        get { applyButton.titleLabel?.text ?? "" }
        set { applyButton.setTitle(newValue, for: .normal) }
    }

    var buttonIsEnabled: Bool {
        get { applyButton.isEnabled }
        set { applyButton.isEnabled = newValue }
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
    func toBarColor(current: Int, max: Int) -> UIColor {
        let progress = Float(current) / Float(max)
        if progress < 0.5 {
            return .dotori(.sub(.green))
        } else if progress < 0.8 {
            return .dotori(.sub(.yellow))
        } else {
            return .dotori(.sub(.red))
        }
    }
}
