import BaseFeature
import DateUtility
import DesignSystem
import MSGLayout
import UIKit
import ViolationDomainInterface

final class ViolationCell: BaseTableViewCell<ViolationModel> {
    private enum Metric {
        static let padding: CGFloat = 16
    }

    private let containerView = UIView()
        .set(\.backgroundColor, .dotori(.background(.bg)))
        .set(\.cornerRadius, 8)
    private let violationTitleLabel = DotoriLabel(font: .body1)
        .set(\.numberOfLines, 0)
    private let dateLabel = DotoriLabel(textColor: .neutral(.n20), font: .body2)

    override func addView() {
        contentView.addSubviews {
            containerView
        }
    }

    override func setLayout() {
        MSGLayout.buildLayout {
            containerView.layout
                .vertical(.toSuperview(), .equal(5))
                .horizontal(.toSuperview())
        }
        MSGLayout.stackedLayout(self.containerView) {
            HStackView {
                violationTitleLabel

                SpacerView()

                dateLabel
            }
            .margin(.all(Metric.padding))
            .alignment(.center)
        }
    }

    override func configureView() {
        self.selectionStyle = .none
    }

    override func adapt(model: ViolationModel) {
        self.violationTitleLabel.text = model.rule
        self.dateLabel.text = model.createDate.toStringWithCustomFormat("yyyy.MM.dd")
    }
}
