import BaseFeature
import CombineUtility
import DesignSystem
import Localization
import MassageDomainInterface
import MSGLayout
import UIKit
import UIKitUtil

final class MassageViewController: BaseStoredViewController<MassageStore> {
    private let massageNavigationBarLabel = DotoriNavigationBarLabel(text: L10n.Massage.massageTitle)
    private let massageTableView = UITableView()
        .set(\.backgroundColor, .clear)
        .set(\.isHidden, true)
        .set(\.separatorStyle, .none)
        .set(\.sectionHeaderHeight, 0)
        .then {
            $0.register(cellType: MassageCell.self)
        }

    private let massageRefreshContorol = DotoriRefreshControl()
    private lazy var massageTableAdapter = TableViewAdapter<GenericSectionModel<MassageRankModel>>(
        tableView: massageTableView
    ) { tableView, indexPath, item in
        let cell: MassageCell = tableView.dequeueReusableCell(for: indexPath)
        cell.adapt(model: item)
        return cell
    }

    private let emptySelfStudyStackView = VStackView(spacing: 8) {
        DotoriIconView(
            size: .custom(.init(width: 73.5, height: 120)),
            image: .Dotori.coffee
        )

        DotoriLabel(L10n.Massage.emptyMassageTitle, font: .subtitle2)

        DotoriLabel(L10n.Massage.applyFromHomeMassageTitle, textColor: .neutral(.n20), font: .caption)
    }.alignment(.center)

    override func addView() {
        view.addSubviews {
            massageTableView
            emptySelfStudyStackView
        }
        massageTableView.refreshControl = massageRefreshContorol
    }

    override func setLayout() {
        MSGLayout.buildLayout {
            massageTableView.layout
                .top(.toSuperview(), .equal(24))
                .horizontal(.toSuperview())
                .bottom(.to(view.safeAreaLayoutGuide))

            emptySelfStudyStackView.layout
                .center(.toSuperview())
        }
    }

    override func configureNavigation() {
        self.navigationItem.setLeftBarButton(massageNavigationBarLabel, animated: true)
    }

    override func bindAction() {
        viewDidLoadPublisher
            .map { Store.Action.viewDidLoad }
            .sink(receiveValue: store.send(_:))
            .store(in: &subscription)

        massageRefreshContorol.controlPublisher(for: .valueChanged)
            .map { _ in Store.Action.fetchMassageRankList }
            .sink(receiveValue: store.send(_:))
            .store(in: &subscription)
    }

    override func bindState() {
        let sharedState = store.state.share()
            .receive(on: DispatchQueue.main)

        sharedState
            .map(\.massageRankList)
            .map { [GenericSectionModel(items: $0)] }
            .sink(receiveValue: massageTableAdapter.updateSections(sections:))
            .store(in: &subscription)

        sharedState
            .map(\.isRefreshing)
            .removeDuplicates()
            .dropFirst(2)
            .sink(with: massageRefreshContorol, receiveValue: { refreshControl, isRefreshing in
                isRefreshing ? refreshControl.beginRefreshing() : refreshControl.endRefreshing()
            })
            .store(in: &subscription)

        sharedState
            .map(\.massageRankList)
            .map(\.isEmpty)
            .removeDuplicates()
            .sink(with: self, receiveValue: { owner, massageIsEmpty in
                owner.massageTableView.isHidden = massageIsEmpty
                owner.emptySelfStudyStackView.isHidden = !massageIsEmpty
            })
            .store(in: &subscription)
    }
}
