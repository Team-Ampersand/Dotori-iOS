import BaseFeature
import DesignSystem
import MSGLayout
import UIKit

final class NoticeCell: BaseTableViewCell<Void> {
    private let signatureView = UIView()
        .set(\.backgroundColor, .blue)
        .set(\.cornerRadius, 6)
        .set(\.clipsToBounds, true)
    private let authorLabel = DotoriLabel("도토리", font: .smalltitle)
    private let dateLabel = DotoriLabel("2023.07.21", textColor: .neutral(.n20), font: .caption)
    private let titleLabel = DotoriLabel("[자습실 관련 공지]", textColor: .neutral(.n20), font: .caption)
    private let contentLabel = DotoriLabel("[자습실 관련 공지]", textColor: .neutral(.n20), font: .caption)
        .set(\.numberOfLines, 2)

    override func setLayout() {
        MSGLayout.stackedLayout(self.contentView) {
            VStackView(spacing: 8) {
                HStackView(spacing: 4) {
                    signatureView
                        .width(12)
                        .height(12)

                    authorLabel

                    SpacerView()

                    dateLabel
                }

                VStackView(spacing: 2) {
                    titleLabel

                    contentLabel
                }
            }
            .margin(.init(top: 12, left: 16, bottom: 12, right: 16))
            .set(\.backgroundColor, .dotori(.neutral(.n50)))
            .set(\.cornerRadius, 8)
        }
        .margin(.vertical(6))
    }

    override func configureView() {
        self.backgroundColor = .clear
        self.selectionStyle = .none
    }
}
