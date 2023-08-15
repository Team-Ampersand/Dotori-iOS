import BaseFeature
import Combine
import CombineUtility
import Configure
import DateUtility
import DesignSystem
import Localization
import MSGLayout
import UIKit

protocol MealCardViewActionProtocol {
    var mealPartDidChanged: AnyPublisher<MealPartTime, Never> { get }
    var prevDateButtonDidTapPublisher: AnyPublisher<Void, Never> { get }
    var nextDateButtonDidTapPublisher: AnyPublisher<Void, Never> { get }
}

final class MealCardView: BaseView {
    private enum Metric {
        static let padding: CGFloat = 24
    }

    private let mealTitleLabel = DotoriLabel(L10n.Home.mealTitle)
    private let prevDateButton = DotoriIconButton(
        image: .Dotori.miniChevronLeft.tintColor(color: .dotori(.neutral(.n20)))
    )
    .set(\.backgroundColor, .dotori(.neutral(.n50)))
    .set(\.cornerRadius, 11)
    private let currentDateLabel = DotoriLabel(
        Date().toStringWithCustomFormat("yyyy.MM.dd (EEEEE)"),
        textColor: .neutral(.n20),
        font: .body2
    )
    private let nextDateButton = DotoriIconButton(
        image: .Dotori.miniChevronRight.tintColor(color: .dotori(.neutral(.n20)))
    )
    .set(\.backgroundColor, .dotori(.neutral(.n50)))
    .set(\.cornerRadius, 11)
    private lazy var dateStackView = HStackView(spacing: 8) {
        prevDateButton
        currentDateLabel
        nextDateButton
    }

    private let mealPartTimeSegmentedControl = MealPartTimeSegmentedControl(items: MealPartTime.allCases.map(\.display))
        .set(\.selectedSegmentIndex, 0)
    private let mealContentStackView = MealContentStackView()

    override func addView() {
        self.addSubviews {
            mealTitleLabel
            dateStackView
            mealPartTimeSegmentedControl
            mealContentStackView
        }
    }

    override func setLayout() {
        MSGLayout.buildLayout {
            mealTitleLabel.layout
                .top(.toSuperview(), .equal(Metric.padding))
                .leading(.toSuperview(), .equal(Metric.padding))

//            [prevDateButton, nextDateButton]
//                .map { $0.layout.size(28) }

            dateStackView.layout
                .top(.toSuperview(), .equal(Metric.padding))
                .trailing(.toSuperview(), .equal(-Metric.padding))

            mealPartTimeSegmentedControl.layout
                .top(.to(dateStackView).bottom, .equal(16))
                .height(55)
                .horizontal(.toSuperview(), .equal(Metric.padding))

            mealContentStackView.layout
                .top(.to(mealPartTimeSegmentedControl).bottom, .equal(16))
                .horizontal(.toSuperview(), .equal(Metric.padding))
                .height(400)
                .bottom(.toSuperview(), .equal(-Metric.padding))
        }
    }

    override func configure() {
        self.backgroundColor = .dotori(.background(.card))
        self.layer.cornerRadius = 16
    }

    public func updateContent(meals: [String]) {
        self.mealContentStackView.updateContent(meals: meals)
    }

    public func updateSelectedDate(date: Date) {
        self.currentDateLabel.text = date.toStringWithCustomFormat("yyyy.MM.dd (EEEEE)")
    }
}

extension MealCardView: MealCardViewActionProtocol {
    var mealPartDidChanged: AnyPublisher<MealPartTime, Never> {
        mealPartTimeSegmentedControl.controlPublisher(for: .valueChanged)
            .compactMap { $0 as? UISegmentedControl }
            .map(\.selectedSegmentIndex)
            .compactMap { MealPartTime(rawValue: $0) }
            .eraseToAnyPublisher()
    }

    var prevDateButtonDidTapPublisher: AnyPublisher<Void, Never> {
        prevDateButton.tapPublisher
    }

    var nextDateButtonDidTapPublisher: AnyPublisher<Void, Never> {
        nextDateButton.tapPublisher
    }
}
