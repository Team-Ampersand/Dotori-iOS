import BaseFeature
import Combine
import CombineUtility
import Configure
import DesignSystem
import GlobalThirdPartyLibrary
import Localization
import MSGLayout
import SelfStudyDomainInterface
import UIKit
import UIKitUtil

final class SelfStudyViewController: BaseStoredViewController<SelfStudyStore> {
    private let selfStudyNavigationBarLabel = DotoriNavigationBarLabel(text: L10n.SelfStudy.selfStudyTitle)
    private let filterBarButton = UIBarButtonItem(
        image: .Dotori.filter.tintColor(color: .dotori(.neutral(.n20))),
        style: .done,
        target: nil,
        action: nil
    )
    private let selfStudyTableView = UITableView()
        .set(\.backgroundColor, .clear)
        .set(\.separatorStyle, .none)
        .set(\.sectionHeaderHeight, 0)
        .set(\.sectionFooterHeight, 0)
        .set(\.isHidden, true)
        .then {
            $0.register(cellType: SelfStudyCell.self)
        }
    private let selfStudyRefreshContorol = DotoriRefreshControl()
    private lazy var selfStudyTableAdapter = TableViewAdapter<GenericSectionModel<SelfStudyRankModel>>(
        tableView: selfStudyTableView
    ) { [weak self] tableView, indexPath, item in
        guard let self else { return .init() }
        let cell: SelfStudyCell = tableView.dequeueReusableCell(for: indexPath)
        cell.adapt(model: item)
        cell.setUserRole(userRole: self.store.currentState.currentUserRole)
        cell.delegate = self
        return cell
    }
    private let emptySelfStudyStackView = VStackView(spacing: 8) {
        DotoriIconView(
            size: .custom(.init(width: 96, height: 77)),
            image: .Dotori.graduationcap
        )

        DotoriLabel(L10n.SelfStudy.emptySelfStudyTitle, font: .subtitle2)

        DotoriLabel(L10n.SelfStudy.applyFromHomeSelfStudyTitle, textColor: .neutral(.n20), font: .caption)
    }.alignment(.center)

    override func addView() {
        view.addSubviews {
            selfStudyTableView
            emptySelfStudyStackView
        }
        selfStudyTableView.refreshControl = selfStudyRefreshContorol
    }

    override func setLayout() {
        MSGLayout.buildLayout {
            selfStudyTableView.layout
                .top(.toSuperview(), .equal(24))
                .horizontal(.toSuperview())
                .bottom(.to(view.safeAreaLayoutGuide))

            emptySelfStudyStackView.layout
                .center(.toSuperview())
        }
    }

    override func configureNavigation() {
        self.navigationItem.setLeftBarButton(selfStudyNavigationBarLabel, animated: true)
        self.navigationItem.setRightBarButton(filterBarButton, animated: true)
    }

    override func bindAction() {
        viewDidLoadPublisher
            .merge(with: selfStudyRefreshContorol.controlPublisher(for: .valueChanged).map { _ in })
            .map { Store.Action.fetchSelfStudyRank }
            .sink(receiveValue: store.send(_:))
            .store(in: &subscription)

        filterBarButton.tapPublisher
            .map { Store.Action.filterButtonDidTap }
            .sink(receiveValue: store.send(_:))
            .store(in: &subscription)
    }

    override func bindState() {
        let sharedState = store.state.share()
            .receive(on: DispatchQueue.main)

        sharedState
            .map(\.selfStudyRankList)
            .removeDuplicates()
            .map { [GenericSectionModel(items: $0)] }
            .sink(receiveValue: selfStudyTableAdapter.updateSections(sections:))
            .store(in: &subscription)

        sharedState
            .map(\.selfStudyRankList)
            .map(\.isEmpty)
            .removeDuplicates()
            .sink(with: self, receiveValue: { owner, selfStudyIsEmpty in
                owner.selfStudyTableView.isHidden = selfStudyIsEmpty
                owner.emptySelfStudyStackView.isHidden = !selfStudyIsEmpty
            })
            .store(in: &subscription)

        sharedState
            .filter { !$0.selfStudyRankList.isEmpty }
            .map(\.isRefreshing)
            .removeDuplicates()
            .sink(with: selfStudyRefreshContorol, receiveValue: { refreshControl, isRefreshing in
                isRefreshing ? refreshControl.beginRefreshing() : refreshControl.endRefreshing()
            })
            .store(in: &subscription)
    }
}

extension SelfStudyViewController: SelfStudyCellDelegate {
    func selfStudyCheckBoxDidTap(id: Int, isChecked: Bool) {
        store.send(.selfStudyCheckButtonDidTap(id: id, isChecked: isChecked))
    }
}
