import BaseFeature
import Combine
import CombineUtility
import Configure
import DesignSystem
import GlobalThirdPartyLibrary
import MSGLayout
import SelfStudyDomainInterface
import UIKit
import UIKitUtil

final class SelfStudyViewController: BaseViewController<SelfStudyStore> {
    private let dotoriNavigationBarLabel = DotoriNavigationBarLabel(text: "자습신청")
    private let filterBarButton = UIBarButtonItem(
        image: .Dotori.filter.tintColor(color: .dotori(.neutral(.n20))),
        style: .done,
        target: nil,
        action: nil
    )
    private let selfStudyTableView = UITableView()
        .set(\.backgroundColor, .clear)
        .set(\.separatorStyle, .none)
        .set(\.isHidden, true)
        .then {
            $0.register(cellType: SelfStudyCell.self)
        }
    private let selfStudyRefreshContorol = UIRefreshControl()
    private lazy var selfStudyTableAdapter = TableViewAdapter<GenericSectionModel<SelfStudyRankModel>>(
        tableView: selfStudyTableView
    ) { [store] tableView, indexPath, item in
        let cell: SelfStudyCell = tableView.dequeueReusableCell(for: indexPath)
        cell.adapt(model: item)
        cell.setUserRole(userRole: store.currentState.currentUserRole)
        cell.delegate = store
        return cell
    }
    private let emptySelfStudyStackView = VStackView(spacing: 8) {
        DotoriIconView(
            size: .custom(.init(width: 96, height: 77)),
            image: .Dotori.graduationcap
        )

        DotoriLabel("자습 신청한 인원이 없습니다.", font: .subtitle2)

        DotoriLabel("홈에서 자습 신청을 해보세요!", textColor: .neutral(.n20), font: .caption)
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
        self.navigationItem.setLeftBarButton(dotoriNavigationBarLabel, animated: true)
        self.navigationItem.setRightBarButton(filterBarButton, animated: true)
    }

    override func bindAction() {
        viewDidLoadPublisher
            .merge(with: selfStudyRefreshContorol.controlPublisher(for: .valueChanged).map { _ in })
            .map { Store.Action.fetchSelfStudyRank }
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
            .map(\.count)
            .map { $0 == 0 }
            .removeDuplicates()
            .sink(with: self, receiveValue: { owner, selfStudyIsEmpty in
                owner.selfStudyTableView.isHidden = selfStudyIsEmpty
                owner.emptySelfStudyStackView.isHidden = !selfStudyIsEmpty
            })
            .store(in: &subscription)

        sharedState
            .map(\.isRefreshing)
            .sink(with: selfStudyRefreshContorol, receiveValue: { refreshControl, isRefreshing in
                isRefreshing ? refreshControl.beginRefreshing() : refreshControl.endRefreshing()
            })
            .store(in: &subscription)
    }
}
