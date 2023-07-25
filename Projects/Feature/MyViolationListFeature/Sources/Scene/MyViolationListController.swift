import BaseFeature
import Combine
import DesignSystem
import Foundation
import Localization
import MSGLayout
import UIKit
import UIKitUtil
import ViolationDomainInterface

final class MyViolationListViewController: BaseStoredModalViewController<MyViolationListStore> {
    private enum Metric {
        static let padding: CGFloat = 24
    }
    private let violationHistoryTitleLabel = DotoriLabel(L10n.ViolationHistory.violationTitle)
    private let xmarkButton = DotoriIconButton(image: .Dotori.xmark)
    private let violationHistoryTableView = UITableView()
        .set(\.backgroundColor, .clear)
        .set(\.separatorStyle, .none)
        .set(\.sectionHeaderHeight, 0)
        .set(\.sectionFooterHeight, 0)
        .then {
            $0.register(cellType: ViolationCell.self)
        }
    private lazy var violationHistoryTableAdapter = TableViewAdapter<GenericSectionModel<ViolationModel>>(
        tableView: violationHistoryTableView
    ) { tableView, indexPath, item in
        let cell: ViolationCell = tableView.dequeueReusableCell(for: indexPath)
        cell.adapt(model: item)
        return cell
    }
    private let confirmButton = DotoriButton(text: L10n.Global.confirmButtonTitle)

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func setLayout() {
        MSGLayout.buildLayout {
            contentView.layout
                .center(.toSuperview())
                .horizontal(.toSuperview(), .equal(20))
        }

        MSGLayout.stackedLayout(self.contentView) {
            VStackView(spacing: 20) {
                HStackView {
                    violationHistoryTitleLabel

                    xmarkButton
                }

                violationHistoryTableView
                    .height(200)

                confirmButton
            }
            .margin(.all(Metric.padding))
        }
        .distribution(.fill)
    }

    override func bindState() {
        
//            .map { [GenericSectionModel(items: $0)] }
//            .sink(receiveValue: violationHistoryTableAdapter.updateSections(sections:))
//            .store(in: &subscription)
    }
}
