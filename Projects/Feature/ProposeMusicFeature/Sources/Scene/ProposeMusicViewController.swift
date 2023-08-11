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

    private let shareTipLabel = DotoriLabel(L10n.ProposeMusic.shareTipTitle, textColor: .neutral(.n20), font: .body2)
        .set(\.numberOfLines, 0)
    private let urlTextField = DotoriSimpleTextField(placeholder: L10n.ProposeMusic.inputUrlPlaceholder)
    private let proposeButton = DotoriButton(text: L10n.ProposeMusic.proposeButtonTitle)
    private let proposeActivityView = UIActivityIndicatorView(style: .medium)

    override func addView() {
        super.addView()
        proposeButton.addSubviews {
            proposeActivityView
        }
    }

    override func setLayout() {
        MSGLayout.buildLayout {
            contentView.layout
                .horizontal(.toSuperview(), .equal(20))
                .center(.toSuperview())

            proposeActivityView.layout
                .center(.toSuperview())
        }

        MSGLayout.stackedLayout(self.contentView) {
            VStackView(spacing: 16) {
                VStackView(spacing: 4) {
                    HStackView {
                        proposeMusicLabel

                        SpacerView()

                        openYoutubeButton
                    }

                    shareTipLabel
                }

                VStackView(spacing: 8) {
                    urlTextField

                    proposeButton
                        .height(52)
                }
            }
            .margin(.all(16))
        }
    }

    override func bindAction() {
        urlTextField.textPublisher
            .map(Store.Action.updateURL)
            .sink(receiveValue: store.send(_:))
            .store(in: &subscription)

        proposeButton.tapPublisher
            .filter { [store] in !store.currentState.isLoading }
            .map { Store.Action.proposeButtonDidTap }
            .sink(receiveValue: store.send(_:))
            .store(in: &subscription)

        view.tapGesturePublisher()
            .map { _ in Store.Action.dimmedBackgroundDidTap }
            .sink(receiveValue: store.send(_:))
            .store(in: &subscription)

        openYoutubeButton.tapPublisher
            .map { Store.Action.youtubeButtonDidTap }
            .sink(receiveValue: store.send(_:))
            .store(in: &subscription)
    }

    override func bindState() {
        let sharedState = store.state.share()
            .receive(on: DispatchQueue.main)

        sharedState
            .map(\.url)
            .removeDuplicates()
            .map(Optional.init)
            .assign(to: \.text, on: urlTextField)
            .store(in: &subscription)

        sharedState
            .map(\.isLoading)
            .removeDuplicates()
            .sink { [proposeButton, proposeActivityView] isLoading in
                let proposeButtonTitle = isLoading ? "" : L10n.ProposeMusic.proposeButtonTitle
                proposeButton.setTitle(proposeButtonTitle, for: .normal)

                isLoading
                    ? proposeActivityView.startAnimating()
                    : proposeActivityView.stopAnimating()
            }
            .store(in: &subscription)
    }
}
