import BaseFeature
import Configure
import DateUtility
import DesignSystem
import LinkPresentation
import MSGLayout
import MusicDomainInterface
import UIKit
import UIKitUtil

final class MusicCell: BaseTableViewCell<MusicModel> {
    private let containerView = UIView()
        .set(\.backgroundColor, .dotori(.background(.card)))
    private let thumbnailView = UIImageView(
        image: .init(systemName: "photo")?
            .tintColor(color: .dotori(.primary(.p10)))
    )
        .set(\.cornerRadius, 8)
        .set(\.clipsToBounds, true)
        .set(\.contentMode, .scaleAspectFit)
    private let titleLabel = DotoriLabel("로딩중...", font: .smalltitle)
        .set(\.numberOfLines, 2)
    private let authorLabel = DotoriLabel(textColor: .neutral(.n20), font: .caption)
    private let meatballButton = DotoriIconButton(
        image: .Dotori.meatBall.tintColor(color: .dotori(.neutral(.n30)))
    )

    override func addView() {
        contentView.addSubviews {
            containerView
        }
    }

    override func setLayout() {
        MSGLayout.buildLayout {
            containerView.layout
                .edges(.toSuperview())
        }
        MSGLayout.stackedLayout(self.containerView) {
            HStackView(spacing: 8) {
                thumbnailView
                    .width(128)
                    .height(72)

                VStackView(spacing: 8) {
                    titleLabel

                    SpacerView()

                    authorLabel
                }
                .distribution(.fill)
                .alignment(.leading)

                meatballButton
            }
            .alignment(.center)
            .margin(.axes(vertical: 8, horizontal: 16))
        }
    }

    override func configureView() {
        self.selectionStyle = .none
    }

    override func adapt(model: MusicModel) {
        super.adapt(model: model)
        let timeString = "\(model.createdTime.hour % 12)시 \(model.createdTime.minute)분"
        authorLabel.text = "\(model.stuNum) \(model.username) • \(timeString)"
        titleLabel.text = model.title
        thumbnailView.image = model.thumbnailUIImage
    }
}
