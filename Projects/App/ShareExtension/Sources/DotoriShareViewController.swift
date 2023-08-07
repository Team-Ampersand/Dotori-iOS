import Combine
import Configure
import DesignSystem
import LinkPresentation
import Localization
import MSGLayout
import MusicDomain
import Social
import UIKit
import UniformTypeIdentifiers

final class DotoriShareViewController: UIViewController {
    private let contentView = UIView()
        .set(\.backgroundColor, .dotori(.background(.card)))
        .set(\.cornerRadius, 10)
        .then {
            $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        }
    private let proposeMusicLabel = DotoriLabel(L10n.ProposeMusic.proposeMusicTitle, font: .subtitle1)
    private let cancelButton = DotoriTextButton(L10n.Global.cancelButtonTitle, textColor: .neutral(.n20), font: .body2)
    private let thumbnailImageView = UIImageView()
        .set(\.contentMode, .scaleAspectFill)
        .set(\.cornerRadius, 8)
        .set(\.clipsToBounds, true)
    private let imageActivityIndicator = UIActivityIndicatorView(style: .medium)
    private let titleLabel = DotoriLabel(font: .smalltitle)
        .set(\.numberOfLines, 0)
    private let proposeButton = DotoriButton(text: L10n.ProposeMusic.proposeButtonTitle)
        .set(\.contentEdgeInsets, .vertical(16))
    private var subscription = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        addView()
        setLayout()
        bindAction()
        bindExtensionInput()
    }
}

private extension DotoriShareViewController {
    func addView() {
        view.addSubviews {
            contentView
        }
        thumbnailImageView.addSubviews {
            imageActivityIndicator
        }
    }

    func setLayout() {
        MSGLayout.buildLayout {
            contentView.layout
                .horizontal(.toSuperview())
                .bottom(.toSuperview())
                .height(268)

            imageActivityIndicator.layout
                .center(.toSuperview())
        }

        MSGLayout.stackedLayout(self.contentView) {
            VStackView(spacing: 8) {
                HStackView {
                    proposeMusicLabel

                    SpacerView()

                    cancelButton
                }
                .alignment(.lastBaseline)

                HStackView(spacing: 8) {
                    thumbnailImageView
                        .width(96)
                        .height(72)

                    titleLabel
                }
                .distribution(.fill)
                .alignment(.center)
                .height(88)
                .margin(.horizontal(8))
                .set(\.backgroundColor, .dotori(.neutral(.n50)))
                .set(\.cornerRadius, 8)

                VStackView {
                    proposeButton
                }
                .margin(.init(top: 16, left: 0, bottom: 8, right: 0))
            }
            .margin(.all(16))
        }
    }

    func bindAction() {
        self.cancelButton.tapPublisher
            .sink(with: self, receiveValue: { owner, _ in
                owner.hideExtension { _ in
                    owner.extensionContext?.cancelRequest(withError: NSError(domain: "Share Canceled", code: 2023))
                }
            })
            .store(in: &subscription)
    }

    func hideExtension(completion: @escaping (Bool) -> Void) {
        UIView.animate(withDuration: 0.3, animations: {
            self.view.transform = CGAffineTransform(
                translationX: 0,
                y: self.view.frame.size.height
            )
        }, completion: completion)
    }

    func bindExtensionInput() {
        guard let extensionInput = extensionContext?.inputItems as? [NSExtensionItem] else {
            self.extensionContext?.cancelRequest(withError: NSError(domain: "Invalid Inputs", code: 1))
            return
        }
        for input in extensionInput where input.attachments?.isEmpty == false  {
            let itemProviders = input.attachments ?? []

            for itemProvider in itemProviders where itemProvider.hasItemConformingToTypeIdentifier("public.url") {
                itemProvider.loadItem(forTypeIdentifier: "public.url", options: nil) { [weak self] item, error in
                    guard let self, let url = item as? URL, error == nil else {
                        self?.hideExtension { _ in
                            self?.extensionContext?.cancelRequest(withError: NSError(domain: "Invalid URL Input", code: 2))
                        }
                        return
                    }

                    DispatchQueue.global(qos: .userInteractive).async {
                        self.bindYoutubeThumbnail(url: url)
                    }
                }
            }
        }
    }

    func bindYoutubeThumbnail(url: URL) {
        DispatchQueue.main.async {
            self.imageActivityIndicator.startAnimating()
        }
        let provider = LPMetadataProvider()
        provider.startFetchingMetadata(for: url) { [weak owner = self] metadata, error in
            guard let owner, let metadata, error == nil else {
                owner?.hideExtension { _ in
                    owner?.extensionContext?.cancelRequest(withError: NSError(domain: "Invalid Youtube Metadata", code: 3))
                }
                return
            }

            metadata.imageProvider?.loadObject(ofClass: UIImage.self) { image, error in
                guard let image = image as? UIImage, error == nil else {
                    owner.hideExtension { _ in
                        owner.extensionContext?.cancelRequest(withError: NSError(domain: "Invalid Youtube Thumbnail Image", code: 4))
                    }
                    return
                }

                DispatchQueue.main.async {
                    self.thumbnailImageView.image = image
                    self.titleLabel.text = metadata.title
                    self.imageActivityIndicator.stopAnimating()
                }
            }
        }
    }
}
