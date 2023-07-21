import BaseFeature
import DesignSystem
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
        noticeTableView.dataSource = self
    }

    override func configureNavigation() {
        self.navigationItem.setLeftBarButton(dotoriBarButton, animated: true)
    }
}

extension NoticeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: NoticeCell.self)
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
}
