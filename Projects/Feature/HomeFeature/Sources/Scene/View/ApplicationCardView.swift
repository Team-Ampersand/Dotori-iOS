import BaseDomainInterface
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
    func updateApplyCount(current: Int, max: Int)
    func updateRecentRefresh(date: Date)
    func updateUserRole(userRole: UserRoleType)
}

protocol ApplicationCardViewActionProtocol {
    var applyButtonDidTapPublisher: AnyPublisher<Void, Never> { get }
    var detailButtonDidTapPublisher: AnyPublisher<Void, Never> { get }
    var refreshButtonDidTapPublisher: AnyPublisher<Void, Never> { get }
    var settingButtonDidTpaPublisher: AnyPublisher<Void, Never> { get }
}

final class ApplicationCardView: BaseView {
    private enum Metric {
        static let padding: CGFloat = 24
        static let spacing: CGFloat = 16
    }

    private let titleButton = DotoriTextButton()
        .set(\.semanticContentAttribute, .forceRightToLeft)
    private let loadingIndicatorView = UIActivityIndicatorView(style: .medium)
    private let refreshButton = DotoriIconButton(
        image: .Dotori.refresh.tintColor(color: .dotori(.neutral(.n10)))
    )
    private let chevronRightButton = DotoriIconButton(
        image: .Dotori.chevronRight.tintColor(color: .dotori(.neutral(.n10)))
    )
    private lazy var headerStackView = HStackView(spacing: 16) {
        titleButton

        loadingIndicatorView

        SpacerView()

        refreshButton

        chevronRightButton
    }

    private let applicationCountStatusLabel = DotoriLabel(font: .h2)
    private let recentRefreshLabel = DotoriLabel(textColor: .neutral(.n20), font: .caption)
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
        self.titleButton.setTitle(title, for: .normal)
        self.applyButton.setTitle(applyText, for: .normal)
        self.applicationCountStatusLabel.text = "0/\(maxApplyCount)"
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func addView() {
        self.addSubviews {
            headerStackView
            applicationCountStatusLabel
            recentRefreshLabel
            applicationProgressView
            applyButton
        }
    }

    override func setLayout() {
        MSGLayout.buildLayout {
            headerStackView.layout
                .top(.toSuperview(), .equal(Metric.padding))
                .horizontal(.toSuperview(), .equal(Metric.padding))

            applicationCountStatusLabel.layout
                .centerX(.toSuperview())
                .top(.to(headerStackView).bottom, .equal(Metric.spacing))

            recentRefreshLabel.layout
                .leading(.to(applicationCountStatusLabel).trailing, .equal(8))
                .bottom(.to(applicationProgressView).top, .equal(-24))

            applicationProgressView.layout
                .centerX(.toSuperview())
                .height(20)
                .top(.to(applicationCountStatusLabel).bottom, .equal(Metric.spacing))
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

    func updateApplyCount(current: Int, max: Int) {
        let newProgress = Float(current) / Float(max)

        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.4, delay: 0) {
            self.applicationProgressView.setProgress(newProgress, animated: true)
            self.applicationProgressView.progressTintColor = self.toBarColor(current: current, max: max)
        }

        self.applicationCountStatusLabel.text = "\(current)/\(max)"
    }

    func updateRecentRefresh(date: Date) {
        let recentRefreshText = self.recentRefreshDateText(date: date)
        self.recentRefreshLabel.text = recentRefreshText
    }

    func updateUserRole(userRole: UserRoleType) {
        if userRole != .member {
            titleButton.setImage(
                .Dotori.setting.tintColor(color: .dotori(.neutral(.n10))),
                for: .normal
            )
        } else {
            titleButton.setImage(nil, for: .normal)
        }
    }
}

extension ApplicationCardView: ApplicationCardViewActionProtocol {
    var applyButtonDidTapPublisher: AnyPublisher<Void, Never> {
        applyButton.tapPublisher
    }

    var detailButtonDidTapPublisher: AnyPublisher<Void, Never> {
        chevronRightButton.tapPublisher
    }

    var refreshButtonDidTapPublisher: AnyPublisher<Void, Never> {
        refreshButton.tapPublisher
    }

    var settingButtonDidTpaPublisher: AnyPublisher<Void, Never> {
        titleButton.tapPublisher
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

    func recentRefreshDateText(date: Date) -> String {
        let currentDate = Date()
        let diffInterval = currentDate.timeIntervalSince(date)
        let diffSecond = Int(diffInterval)
        let diffMinute = diffSecond / 60
        let diffHour = diffMinute / 60

        if diffHour > 0 {
            return L10n.Home.previousHourTitle(diffHour)
        } else if diffMinute > 0 {
            return L10n.Home.previousMinuateTitle(diffMinute)
        } else {
            return L10n.Home.previousSecondTitle(diffSecond)
        }
    }
}
