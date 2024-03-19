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

    let pipeline = ImagePipeline.shared
    private var editProfileTitleLabel = DotoriLabel(L10n.ProfileImage.selectProfileImage)
    private let xmarkButton = DotoriIconButton(image: .Dotori.xmark)
    private let addImageButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.image = UIImage(systemName: "camera.fill")
        configuration.imagePlacement = .top
        configuration.imagePadding = 10
        configuration.background.backgroundColor = .dotori(.background(.bg))
        configuration.title = L10n.ProfileImage.addImage
        configuration.titleAlignment = .center
        configuration.attributedTitle?.foregroundColor = .dotori(.neutral(.n20))
        configuration.attributedTitle?.font = .dotori(.caption)
        configuration.baseForegroundColor = .dotori(.primary(.p30))
        configuration.background.cornerRadius = 8
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 112, leading: 108, bottom: 104, trailing: 108)
        let button = UIButton(configuration: configuration)
        button.imageView?.contentMode = .scaleAspectFill
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let deleteProfileImageButton = UIButton()
        .set(\.backgroundColor, .dotori(.background(.bg)))
        .set(\.cornerRadius, 5)
        .set(\.clipsToBounds, true)
        .set(\.tintColor, .dotori(.system(.error)))
        .then { $0.setImage(UIImage(systemName: "trash"), for: .normal) }
        .then { $0.isEnabled = false }
        .then { $0.isHidden = true }

    private let confirmButton = DotoriButton(text: L10n.Global.confirmButtonTitle)

    func addImageButtonTapped() {
        var configuration = YPImagePickerConfiguration()
        configuration.startOnScreen = .library
        configuration.library.maxNumberOfItems = 1
        configuration.library.mediaType = .photo
        configuration.library.defaultMultipleSelection = false
        configuration.showsCrop = .rectangle(ratio: 4/4)

        let imagePicker = YPImagePicker(configuration: configuration)
        present(imagePicker, animated: true, completion: nil)

        imagePicker.didFinishPicking {
            [addImageButton, editProfileTitleLabel, deleteProfileImageButton, store] items, _ in

            if let photo = items.singlePhoto {
                if var configuration = addImageButton.configuration {
                    configuration.background.image = photo.image
                    configuration.image = nil
                    configuration.title = nil
                    addImageButton.imageView?.contentMode = .scaleAspectFill
                    addImageButton.configuration = configuration
                }
                imagePicker.dismiss(animated: true) {
                    if let imageData = photo.image.jpegData(compressionQuality: 0.8) {
                        store.send(.addProfileImage(imageData))
                    }
                    deleteProfileImageButton.isHidden = true
                    deleteProfileImageButton.isEnabled = true
                    DispatchQueue.main.async {
                        addImageButton.removeDashedBorder()
                        addImageButton.setNeedsDisplay()
                    }
                }
            }
            imagePicker.dismiss(animated: true) {}
        }
    }

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
            .map { Store.Action.fetchProfileImageCase }
            .sink(receiveValue: store.send(_:))
            .store(in: &subscription)

        xmarkButton.tapPublisher
            .map { Store.Action.xmarkButtonDidTap }
            .sink(receiveValue: store.send(_:))
            .store(in: &subscription)

        addImageButton.tapPublisher
            .sink { [weak self] _ in
                self?.addImageButtonTapped()
            }
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
            .compactMap(\.fetchedProfileImage)
            .sink(with: self, receiveValue: { owner, fetchedProfileImage in
                let request = ImageRequest(
                    url: URL(string: fetchedProfileImage),
                    priority: .high,
                    options: [.reloadIgnoringCachedData]
                )

                Task {
                    do {
                        let image = try await self.pipeline.image(for: request)
                        self.addImageButton.configuration?.background.image = image
                        DispatchQueue.main.async {
                            self.addImageButton.removeDashedBorder()
                            self.addImageButton.setNeedsDisplay()
                        }
                        self.editProfileTitleLabel.text = L10n.ProfileImage.editImage
                        self.deleteProfileImageButton.isHidden = false
                        self.deleteProfileImageButton.isEnabled = true
                    }
                }
                owner.addImageButton.isEnabled = false
                owner.addImageButton.configuration?.image = nil
                owner.addImageButton.configuration?.title = nil
            })
            .store(in: &subscription)

        sharedState
            .map(\.profileImage)
            .removeDuplicates()
            .sink { [weak self] profileImage in
            }
            .store(in: &subscription)
    }
}
