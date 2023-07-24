import BaseFeature
import Combine
import Configure
import DesignSystem
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
        .then {
            $0.register(cellType: SelfStudyCell.self)
        }
    private lazy var selfStudyTableAdapter = TableViewAdapter<GenericSectionModel<SelfStudyRankModel>>(
        tableView: selfStudyTableView
    ) { [store] tableView, indexPath, item in
        let cell: SelfStudyCell = tableView.dequeueReusableCell(for: indexPath)
        cell.adapt(model: item)
        cell.delegate = store
        return cell
    }

    override func addView() {
        view.addSubviews {
            selfStudyTableView
        }
    }

    override func setLayout() {
        MSGLayout.buildLayout {
            selfStudyTableView.layout
                .top(.toSuperview(), .equal(24))
                .horizontal(.toSuperview())
                .bottom(.to(view.safeAreaLayoutGuide))
        }
    }

    override func configureNavigation() {
        self.navigationItem.setLeftBarButton(dotoriNavigationBarLabel, animated: true)
        self.navigationItem.setRightBarButton(filterBarButton, animated: true)
    }

    override func bindAction() {
        viewDidLoadPublisher
            .map { Store.Action.viewDidLoad }
            .sink(receiveValue: store.send(_:))
            .store(in: &subscription)
    }

    override func bindState() {
        let sharedState = store.state.share()
            .receive(on: DispatchQueue.main)

        sharedState
            .map(\.selfStudyRankList)
            .map { [GenericSectionModel(items: $0)] }
            .sink(receiveValue: selfStudyTableAdapter.updateSections(sections:))
            .store(in: &subscription)
    }
}
