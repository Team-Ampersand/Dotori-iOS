import BaseFeature
import DesignSystem
import Localization
import MSGLayout
import MassageDomainInterface
import UIKit
import UIKitUtil

final class MassageViewController: BaseStoredViewController<MassageStore> {
    private let massageNavigationBarLabel = DotoriNavigationBarLabel(text: L10n.Massage.massageTitle)
    private let massageTableView = UITableView()
        .set(\.backgroundColor, .clear)
        .set(\.separatorStyle, .none)
        .set(\.isHidden, true)
        .then {
            $0.register(cellType: MassageCell.self)
        }
    private let massageRefreshContorol = UIRefreshControl()
    private lazy var massageTableAdapter = TableViewAdapter<GenericSectionModel<MassageRankModel>>(
        tableView: massageTableView
    ) { [store] tableView, indexPath, item in
        let cell: MassageCell = tableView.dequeueReusableCell(for: indexPath)
        cell.adapt(model: item)
        cell.setUserRole(userRole: store.currentState.currentUserRole)
        return cell
    }

    override func addView() {
        view.addSubviews {
            massageTableView
        }
        massageTableView.refreshControl = massageRefreshContorol
    }

    override func setLayout() {
        MSGLayout.buildLayout {
            massageTableView.layout
                .top(.toSuperview(), .equal(24))
                .horizontal(.toSuperview())
                .bottom(.to(view.safeAreaLayoutGuide))
        }
    }

    override func configureNavigation() {
        self.navigationItem.setLeftBarButton(massageNavigationBarLabel, animated: true)
    }
}
