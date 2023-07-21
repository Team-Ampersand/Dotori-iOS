import BaseFeature
import Combine
import CombineUtility
import DesignSystem
import GlobalThirdPartyLibrary
import Localization
import MSGLayout
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
        .then {
            $0.register(cellType: NoticeCell.self)
        }
    private lazy var noticeTableAdapter = TableViewAdapter(tableView: noticeTableView).then {
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
                .horizontal(.toSuperview(), .equal(Metric.horizontalPadding))
                .bottom(.toSuperview())
        }
    }

    override func configureNavigation() {
        self.navigationItem.setLeftBarButton(dotoriBarButton, animated: true)
    }

    override func bindState() {
        Just([(), (), ()])
            .map { [GenericTableViewSectionModel<Void, NoticeCell>(models: $0)] }
            .sink(receiveValue: { [noticeTableAdapter] sectionModels in
                noticeTableAdapter.updateSections(sections: sectionModels)
            })
            .store(in: &subscription)
    }
}
