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
        .set(\.cornerRadius, 8)
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

    private let emptyViolationLabel = DotoriLabel(
        L10n.ViolationHistory.emptyViolationTitle,
        textColor: .neutral(.n30),
        font: .smalltitle
    ).set(\.isHidden, true)
    private let confirmButton = DotoriButton(text: L10n.Global.confirmButtonTitle)

    override func addView() {
        super.addView()
        violationHistoryTableView.addSubviews {
            emptyViolationLabel
        }
    }

    override func setLayout() {
        MSGLayout.buildLayout {
            contentView.layout
                .center(.toSuperview())
                .horizontal(.toSuperview(), .equal(20))

            emptyViolationLabel.layout
                .center(.toSuperview())
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

    override func bindAction() {
        viewWillAppearPublisher
            .map { Store.Action.fetchMyViolationList }
            .sink(receiveValue: store.send(_:))
            .store(in: &subscription)

        xmarkButton.tapPublisher
            .map { Store.Action.xmarkButtonDidTap }
            .sink(receiveValue: store.send(_:))
            .store(in: &subscription)

        view.tapGesturePublisher()
            .map { _ in Store.Action.dimmedBackgroundDidTap }
            .sink(receiveValue: store.send(_:))
            .store(in: &subscription)

        confirmButton.tapPublisher
            .map { Store.Action.confirmButtonDidTap }
            .sink(receiveValue: store.send(_:))
            .store(in: &subscription)
    }

    override func bindState() {
        let sharedState = store.state.share()
            .receive(on: DispatchQueue.main)

        sharedState
            .map(\.violationList)
            .map { [GenericSectionModel(items: $0)] }
            .sink(receiveValue: violationHistoryTableAdapter.updateSections(sections:))
            .store(in: &subscription)

        sharedState
            .map(\.violationList)
            .map(\.count)
            .map { $0 == 0 }
            .sink(with: self, receiveValue: { owner, violationIsEmpty in
                owner.violationHistoryTableView.backgroundColor = violationIsEmpty
                    ? .dotori(.background(.bg))
                    : .clear
                owner.emptyViolationLabel.isHidden = !violationIsEmpty
            })
            .store(in: &subscription)
    }
}
