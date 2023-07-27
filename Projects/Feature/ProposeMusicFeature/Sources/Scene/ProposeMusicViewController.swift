import BaseFeature
import DesignSystem
import Localization
import MSGLayout
import UIKit

final class ProposeMusicViewController: BaseStoredModalViewController<ProposeMusicStore> {
    private let proposeMusicLabel = DotoriLabel(L10n.ProposeMusic.proposeMusicTitle, font: .subtitle1)
    private let openYoutubeButton = DotoriTextButton("Youtube", textColor: .neutral(.n20), font: .smalltitle).then {
        let attributedString = NSMutableAttributedString(string: "Youtube")
        attributedString.addAttribute(
            .underlineStyle,
            value: NSUnderlineStyle.single.rawValue,
            range: NSRange(location: 0, length: attributedString.length)
        )
        $0.setAttributedTitle(attributedString, for: .normal)
    }
    private let shareTipLabel = DotoriLabel()
    private let urlTextField = DotoriSimpleTextField(placeholder: L10n.ProposeMusic.inputUrlPlaceholder)
    private let proposeButton = DotoriButton(text: L10n.ProposeMusic.proposeButtonTitle)

    override func addView() {
        super.addView()
    }

    override func setLayout() {
        MSGLayout.buildLayout {
            contentView.layout
                .horizontal(.toSuperview(), .equal(20))
                .center(.toSuperview())
        }

        MSGLayout.stackedLayout(self.contentView) {
            VStackView(spacing: 16) {
                HStackView {
                    proposeMusicLabel

                    SpacerView()

                    openYoutubeButton
                }

                VStackView(spacing: 8) {
                    urlTextField

                    proposeButton
                }
            }
            .margin(.all(16))
        }
    }
}
