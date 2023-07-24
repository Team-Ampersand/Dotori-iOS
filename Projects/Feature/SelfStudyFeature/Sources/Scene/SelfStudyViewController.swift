import BaseFeature
import Combine
import Configure
import DesignSystem
import MSGLayout
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
    private lazy var selfStudyTableAdapter = TableViewAdapter<GenericSectionModel<Void>>(
        tableView: selfStudyTableView
    ) { tableView, indexPath, item in
        let cell: SelfStudyCell = tableView.dequeueReusableCell(for: indexPath)
        cell.adapt(model: item)
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
                .vertical(.to(view.safeAreaLayoutGuide))
                .horizontal(.toSuperview())
        }
    }

    override func configureNavigation() {
        self.navigationItem.setLeftBarButton(dotoriNavigationBarLabel, animated: true)
        self.navigationItem.setRightBarButton(filterBarButton, animated: true)
    }

    override func bindState() {
        Just([(), ()])
            .map { [GenericSectionModel(items: $0)] }
            .sink(receiveValue: selfStudyTableAdapter.updateSections(sections:))
            .store(in: &subscription)
    }
}
