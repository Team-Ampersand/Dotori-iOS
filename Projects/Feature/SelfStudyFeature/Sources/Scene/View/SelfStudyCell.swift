import BaseFeature
import DesignSystem
import MSGLayout
import UIKit

final class SelfStudyCell: BaseTableViewCell<Void> {
    private let containerView = UIView()
    private let rankLabel = DotoriLabel("1", textColor: .neutral(.n20), font: .caption)
    private let selfStudyCheckBox = DotoriCheckBox()
    private let userImageView = DotoriIconView(
        size: .custom(.init(width: 64, height: 64)),
        image: .Dotori.person
    )

    override func addView() {
        contentView.addSubviews {
            containerView
        }
        containerView.addSubviews {
            rankLabel
            selfStudyCheckBox
            userImageView
        }
    }

    override func setLayout() {
        MSGLayout.buildLayout {
            containerView.layout
                .horizontal(.toSuperview(), .equal(20))
                .vertical(.toSuperview(), .equal(12))

            rankLabel.layout
                .top(.toSuperview(), .equal(12))
                .leading(.toSuperview(), .equal(16))

            selfStudyCheckBox.layout
                .top(.toSuperview(), .equal(12))
                .trailing(.toSuperview(), .equal(-12))
                .size(24)

            userImageView.layout
                .centerX(.toSuperview())
                .top(.toSuperview(), .equal(24))
                .bottom(.toSuperview())
        }
    }

    override func configureView() {
        self.contentView.backgroundColor = .dotori(.background(.card))
        self.backgroundColor = .clear
        self.selectionStyle = .none
    }
}
