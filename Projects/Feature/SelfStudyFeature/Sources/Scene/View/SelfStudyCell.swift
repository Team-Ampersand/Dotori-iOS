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
        image: .Dotori.personRectangle
    )
    private let nameLabel = DotoriLabel("김준", textColor: .neutral(.n10), font: .body1)
    private let genderImageView = DotoriIconView(
        size: .custom(.init(width: 16, height: 16)),
        image: .Dotori.men
    )
    private let gradeClassLabel = DotoriLabel("3218", textColor: .neutral(.n20), font: .caption)
    private lazy var profileStackView = VStackView(spacing: 8) {
        userImageView

        HStackView(spacing: 2) {
            nameLabel

            genderImageView
        }
        .alignment(.center)

        gradeClassLabel
    }.alignment(.center)

    override func addView() {
        contentView.addSubviews {
            containerView
        }
        containerView.addSubviews {
            rankLabel
            selfStudyCheckBox
            profileStackView
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

            profileStackView.layout
                .centerX(.toSuperview())
                .top(.toSuperview(), .equal(24))
                .bottom(.toSuperview(), .equal(-24))
        }
    }

    override func configureView() {
        self.containerView.backgroundColor = .dotori(.background(.card))
        self.containerView.cornerRadius = 16
        self.backgroundColor = .clear
        self.selectionStyle = .none
    }
}
