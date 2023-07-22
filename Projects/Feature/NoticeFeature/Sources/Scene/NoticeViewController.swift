import BaseFeature
import Combine
import CombineUtility
import DesignSystem
import GlobalThirdPartyLibrary
import Localization
import MSGLayout
import NoticeDomainInterface
import UIKit
import UIKitUtil

final class NoticeViewController: BaseViewController<NoticeStore> {
    private enum Metric {
        static let horizontalPadding: CGFloat = 20
        static let spacing: CGFloat = 12
    }
    private let dotoriBarButton = DotoriBarButtonItem()
    private let entireTitleLabel = DotoriLabel(L10n.Notice.entireTitle, font: .subtitle1)
    private let noticeTableView = UITableView()
        .set(\.backgroundColor, .clear)
        .set(\.separatorStyle, .none)
        .set(\.sectionHeaderTopPadding, 0)
        .set(\.allowsMultipleSelection, true)
        .then {
            $0.register(cellType: NoticeCell.self)
        }
    private lazy var noticeTableAdapter = TableViewAdapter<GenericSectionModel<NoticeModel>>(
        tableView: noticeTableView
    ) { tableView, indexPath, notice in
        let cell: NoticeCell = tableView.dequeueReusableCell(for: indexPath)
        cell.adapt(model: notice)
        return cell
    } viewForHeaderInSection: { [store] _, index in
        let sectionTitle = store.currentState.noticeSectionList[index].section
        return NoticeSectionLabel(title: sectionTitle)
    }

    override func addView() {
        view.addSubviews {
            entireTitleLabel
            noticeTableView
        }
    }

    override func setLayout() {
        MSGLayout.buildLayout {
            entireTitleLabel.layout
                .top(.to(view.safeAreaLayoutGuide), .equal(13))
                .leading(.toSuperview(), .equal(Metric.horizontalPadding))

            noticeTableView.layout
                .top(.to(entireTitleLabel).bottom, .equal(24))
                .horizontal(.toSuperview())
                .bottom(.to(view.safeAreaLayoutGuide))
        }
    }

    override func configureNavigation() {
        self.navigationItem.setLeftBarButton(dotoriBarButton, animated: true)
        self.view.backgroundColor = .dotori(.background(.card))
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
            .map(\.noticeSectionList)
            .map { noticeSection in
                noticeSection.map { _, noticeList in
                    GenericSectionModel(items: noticeList)
                }
            }
            .sink(receiveValue: noticeTableAdapter.updateSections(sections:))
            .store(in: &subscription)

        sharedState
            .map(\.currentUserRole)
            .map { $0 != .member }
            .assign(to: \.allowsSelection, on: noticeTableView)
            .store(in: &subscription)
    }
}
