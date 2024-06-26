import BaseFeature
import Combine
import ConcurrencyUtil
import DesignSystem
import Foundation
import Localization
import MSGLayout
import Nuke
import UIKit
import UIKitUtil
import UserDomainInterface
import YPImagePicker

final class ProfileImageViewController: BaseStoredModalViewController<ProfileImageStore> {
    private enum Metric {
        static let padding: CGFloat = 24
    }

    private var editProfileTitleLabel = DotoriLabel(L10n.ProfileImage.selectProfileImage)
    private let xmarkButton = DotoriIconButton(image: .Dotori.xmark)

    private let addImageButton = UIButton().then {
        $0.configuration = AddImageButtonConfigutionGenerater.generate()
        $0.imageView?.contentMode = .scaleAspectFit
    }

    private let deleteProfileImageButton = UIButton()
        .set(\.backgroundColor, .dotori(.background(.bg)))
        .set(\.cornerRadius, 5)
        .set(\.clipsToBounds, true)
        .set(\.tintColor, .dotori(.system(.error)))
        .set(\.isHidden, true)
        .set(\.isEnabled, false)
        .then { $0.setImage(UIImage(systemName: "trash"), for: .normal) }

    private let confirmButton = DotoriButton(text: L10n.Global.confirmButtonTitle)

    override func addView() {
        super.addView()
        view.addSubview(contentView)
        contentView.addSubview(deleteProfileImageButton)
    }

    override func setLayout() {
        MSGLayout.buildLayout {
            contentView.layout
                .center(.toSuperview())
                .horizontal(.toSuperview(), .equal(20))

            deleteProfileImageButton.layout
                .top(.toSuperview(), .equal(74))
                .trailing(.toSuperview(), .equal(-36))
                .width(24)
                .height(24)
        }
        MSGLayout.stackedLayout(self.contentView) {
            VStackView(spacing: 16) {
                HStackView {
                    editProfileTitleLabel

                    xmarkButton
                }

                addImageButton
                    .width(272)
                    .height(266)

                confirmButton
            }
            .margin(.all(Metric.padding))
        }
        .distribution(.fill)
        contentView.bringSubviewToFront(deleteProfileImageButton)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.setNeedsLayout()
        addImageButton.addDashedBorder()
    }

    override func bindAction() {
        viewWillAppearPublisher
            .map { Store.Action.fetchProfileImage }
            .sink(receiveValue: store.send(_:))
            .store(in: &subscription)

        xmarkButton.tapPublisher
            .map { Store.Action.xmarkButtonDidTap }
            .sink(receiveValue: store.send(_:))
            .store(in: &subscription)

        addImageButton.tapPublisher
            .map { Store.Action.addImageButtonDidTap }
            .sink(receiveValue: store.send(_:))
            .store(in: &subscription)

        deleteProfileImageButton.tapPublisher
            .map { Store.Action.deleteProfileImageButtonDidTap }
            .sink(receiveValue: store.send(_:))
            .store(in: &subscription)

        view.tapGesturePublisher()
            .map { _ in Store.Action.dimmedBackgroundDidTap }
            .sink(receiveValue: store.send(_:))
            .store(in: &subscription)

        confirmButton.tapPublisher
            .map { Store.Action.confirmButtonDidTap }
            .sink(receiveValue: store.send(_:))
            .store(in: &subscription)
    }

    override func bindState() {
        let sharedState = store.state.share()
            .receive(on: DispatchQueue.main)

        sharedState
            .compactMap(\.fetchedCurrentProfileImageURL)
            .sink(with: self, receiveValue: { owner, fetchedCurrentProfileImageURL in
                let request = ImageRequest(
                    url: URL(string: fetchedCurrentProfileImageURL),
                    priority: .high,
                    options: [.reloadIgnoringCachedData]
                )

                Task {
                    do {
                        let image = try await ImagePipeline.shared.image(for: request)
                        owner.addImageButton.configuration?.background.image = image
                        DispatchQueue.main.async {
                            owner.addImageButton.removeAllSublayers()
                            owner.addImageButton.setNeedsDisplay()
                        }
                        owner.editProfileTitleLabel.text = L10n.ProfileImage.editImage
                        owner.deleteProfileImageButton.isHidden = false
                        owner.deleteProfileImageButton.isEnabled = true
                    }
                }
                owner.addImageButton.isEnabled = false
                owner.addImageButton.configuration?.image = nil
                owner.addImageButton.configuration?.title = nil
            })
            .store(in: &subscription)

        sharedState
            .compactMap(\.selectedProfileImage)
            .sink(with: self, receiveValue: { owner, selectedProfileImage in
                owner.addImageButton.configuration?.background.image = UIImage(data: selectedProfileImage)
                owner.editProfileTitleLabel.text = L10n.ProfileImage.addImage
                owner.deleteProfileImageButton.isHidden = true
                owner.deleteProfileImageButton.isEnabled = false
                owner.addImageButton.isEnabled = false
                owner.addImageButton.configuration?.image = nil
                owner.addImageButton.configuration?.title = nil
                DispatchQueue.main.async {
                    owner.addImageButton.removeAllSublayers()
                    owner.addImageButton.setNeedsDisplay()
                }
            })
            .store(in: &subscription)
    }
}
