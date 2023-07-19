import BaseFeature
import CombineUtility
import Configure
import DateUtility
import DesignSystem
import Localization
import MSGLayout
import UIKit

final class HomeViewController: BaseViewController<HomeStore> {
    private enum Metric {
        static let horizontalPadding: CGFloat = 20
        static let spacing: CGFloat = 12
    }
    private let scrollView = UIScrollView()
    private lazy var dotoriBarButtonItem = UIBarButtonItem(title: "DOTORI", style: .done, target: nil, action: nil)
        .set(\.isEnabled, false)
        .then {
            $0.setTitleTextAttributes([
                .font: UIFont.dotori(.h3),
                .foregroundColor: UIColor.dotori(.primary(.p10))
            ], for: .disabled)
        }
    private lazy var myInfoImageView = UIImageView(image: .Dotori.personCircle)
    private lazy var myInfoBarButtonItem = UIBarButtonItem(customView: myInfoImageView)
    private let timeHeaderView = TimeHeaderView()
    private let selfStudyApplicationCardView = ApplicationCardView(
        title: L10n.Home.selfStudyApplyTitle,
        applyText: L10n.Home.selfStudyApplyButtonTitle,
        maxApplyCount: 50
    )
    private let massageApplicationCardView = ApplicationCardView(
        title: L10n.Home.massageApplyTitle,
        applyText: L10n.Home.massageApplyButtonTitle,
        maxApplyCount: 5
    )
    private let mealCardView = MealCardView()

    override func setLayout() {
        MSGLayout.stackedScrollLayout(view) {
            VStackView(spacing: 16) {
                SpacerView(height: 8)

                timeHeaderView

                selfStudyApplicationCardView

                massageApplicationCardView

                mealCardView

                SpacerView(height: 32)
            }
            .margin(.horizontal(20))
        }
    }

    override func configureNavigation() {
        self.navigationItem.setLeftBarButton(dotoriBarButtonItem, animated: true)
        self.navigationItem.setRightBarButton(myInfoBarButtonItem, animated: true)
    }

    override func bindAction() {
        viewDidLoadPublisher
            .map { Store.Action.viewDidLoad }
            .sink(receiveValue: store.send(_:))
            .store(in: &subscription)

        myInfoImageView.tapGesturePublisher()
            .map { _ in Store.Action.myInfoButtonDidTap }
            .sink(receiveValue: store.send(_:))
            .store(in: &subscription)

        mealCardView.prevDateButtonDidTapPublisher
            .map { Store.Action.prevDateButtonDidTap }
            .sink(receiveValue: store.send(_:))
            .store(in: &subscription)

        mealCardView.nextDateButtonDidTapPublisher
            .map { Store.Action.nextDateButtonDidTap }
            .sink(receiveValue: store.send(_:))
            .store(in: &subscription)

        mealCardView.mealPartDidChanged
            .map(\.toMealType)
            .map(Store.Action.mealTypeDidChanged)
            .sink(receiveValue: store.send(_:))
            .store(in: &subscription)

        selfStudyApplicationCardView.detailButtonDidTapPublisher
            .map { Store.Action.selfStudyDetailButtonDidTap }
            .sink(receiveValue: store.send(_:))
            .store(in: &subscription)

        selfStudyApplicationCardView.applyButtonDidTapPublisher
            .map { Store.Action.applySelfStudyButtonDidTap }
            .sink(receiveValue: store.send(_:))
            .store(in: &subscription)

        massageApplicationCardView.detailButtonDidTapPublisher
            .map { Store.Action.massageDetailButtonDidTap }
            .sink(receiveValue: store.send(_:))
            .store(in: &subscription)

        selfStudyApplicationCardView.refreshButtonDidTapPublisher
            .map { Store.Action.refreshSelfStudyButtonDidTap }
            .sink(receiveValue: store.send(_:))
            .store(in: &subscription)

        massageApplicationCardView.refreshButtonDidTapPublisher
            .map { Store.Action.refreshMassageButtonDidTap }
            .sink(receiveValue: store.send(_:))
            .store(in: &subscription)
    }

    override func bindState() {
        let sharedState = store.state.share()
            .receive(on: DispatchQueue.main)

        sharedState
            .map(\.selfStudyInfo)
            .removeDuplicates { lhs, rhs in lhs.0 == rhs.0 && lhs.1 == rhs.1 }
            .sink(with: selfStudyApplicationCardView, receiveValue: {
                $0.updateApplyCount(current: $1.0, max: $1.1)
            })
            .store(in: &subscription)

        sharedState
            .map(\.massageInfo)
            .removeDuplicates { lhs, rhs in lhs.0 == rhs.0 && lhs.1 == rhs.1 }
            .sink(with: massageApplicationCardView, receiveValue: {
                $0.updateApplyCount(current: $1.0, max: $1.1)
            })
            .store(in: &subscription)

        sharedState
            .map(\.currentTime)
            .sink(receiveValue: timeHeaderView.updateTime(time:))
            .store(in: &subscription)

        sharedState
            .map(\.currentTime)
            .filter { $0.hour == 20 && $0.minute == 0 && $0.second == 0 }
            .sink(with: store, receiveValue: { store, _ in
                store.send(.refreshSelfStudyButtonDidTap)
            })
            .store(in: &subscription)

        sharedState
            .map(\.loadingState)
            .removeDuplicates()
            .map { $0.contains(.selfStudy) }
            .assign(to: \.isLoading, on: selfStudyApplicationCardView)
            .store(in: &subscription)

        sharedState
            .map(\.loadingState)
            .removeDuplicates()
            .map { $0.contains(.massage) }
            .assign(to: \.isLoading, on: massageApplicationCardView)
            .store(in: &subscription)

        sharedState
            .map { state in
                state.mealInfo
                    .filter { $0.mealType == state.selectedMealType }
                    .first?
                    .meals ?? []
            }
            .removeDuplicates()
            .sink(receiveValue: mealCardView.updateContent(meals:))
            .store(in: &subscription)

        sharedState
            .map(\.selectedMealDate)
            .removeDuplicates()
            .sink(receiveValue: mealCardView.updateSelectedDate(date:))
            .store(in: &subscription)

        sharedState
            .map(\.selfStudyButtonTitle)
            .removeDuplicates()
            .assign(to: \.buttonTitle, on: selfStudyApplicationCardView)
            .store(in: &subscription)

        sharedState
            .map(\.selfStudyButtonIsEnabled)
            .removeDuplicates()
            .assign(to: \.buttonIsEnabled, on: selfStudyApplicationCardView)
            .store(in: &subscription)

        sharedState
            .map(\.massageButtonTitle)
            .removeDuplicates()
            .assign(to: \.buttonTitle, on: massageApplicationCardView)
            .store(in: &subscription)

        sharedState
            .map(\.massageButtonIsEnabled)
            .removeDuplicates()
            .assign(to: \.buttonIsEnabled, on: massageApplicationCardView)
            .store(in: &subscription)

        sharedState
            .map(\.selfStudyRefreshDate)
            .removeDuplicates()
            .sink(receiveValue: selfStudyApplicationCardView.updateRecentRefresh(date:))
            .store(in: &subscription)

        sharedState
            .map(\.massageRefreshDate)
            .removeDuplicates()
            .sink(receiveValue: massageApplicationCardView.updateRecentRefresh(date:))
            .store(in: &subscription)
    }
}
