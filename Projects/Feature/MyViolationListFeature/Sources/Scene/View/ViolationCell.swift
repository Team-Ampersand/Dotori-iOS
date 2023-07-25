import BaseFeature
import DesignSystem
import MSGLayout
import UIKit

final class ViolationCell: BaseTableViewCell<Void> {
    private enum Metric {
        static let padding: CGFloat = 16
    }
    private let containerView = UIView()
        .set(\.backgroundColor, .dotori(.background(.bg)))
        .set(\.cornerRadius, 8)
    private let violationTitleLabel = DotoriLabel("타호실 출입", font: .body1)
    private let dateLabel = DotoriLabel("2023.07.13", textColor: .neutral(.n20), font: .body2)

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
}
