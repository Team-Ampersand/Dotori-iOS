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
        .then {
            $0.register(cellType: NoticeCell.self)
        }
    private lazy var noticeTableAdapter = TableViewAdapter(tableView: noticeTableView).then {
        $0.viewForHeaderInSection = { [store] _, index in
            guard store.currentState.sectionsByYearAndMonth.count > index else { return nil }
            return NoticeSectionLabel(title: store.currentState.sectionsByYearAndMonth[index].0)
        }
        noticeTableView.setAdapter(adapter: $0)
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
            .map(\.sectionsByYearAndMonth)
            .map { sections in
                sections.map {
                    GenericTableViewSectionModel<NoticeModel, NoticeCell>(models: $0.1)
                }
            }
            .sink(receiveValue: noticeTableAdapter.updateSections(sections:))
            .store(in: &subscription)
    }
}
