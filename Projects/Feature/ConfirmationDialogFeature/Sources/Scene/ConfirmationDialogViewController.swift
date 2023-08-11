import Anim
import BaseFeature
import CombineUtility
import DesignSystem
import GlobalThirdPartyLibrary
import Localization
import MSGLayout
import UIKit

final class ConfirmationDialogViewController: BaseStoredModalViewController<ConfirmationDialogStore> {
    private enum Metric {
        static let horizontalPadding: CGFloat = 40
        static let spacing: CGFloat = 8
    }

    private let titleLabel = DotoriLabel(font: .subtitle1)
    private let descriptionLabel = DotoriLabel(textColor: .neutral(.n20), font: .body2)
        .set(\.numberOfLines, 2)
    private let cancelButton = DotoriButton(text: L10n.Global.cancelButtonTitle)
        .set(\.contentEdgeInsets, .vertical(12))
    private let confirmButton = DotoriOutlineButton()
        .set(\.contentEdgeInsets, .vertical(12))
    private let loadingIndicatorView = UIActivityIndicatorView(style: .medium)

    init(
        title: String,
        description: String,
        store: ConfirmationDialogStore
    ) {
        super.init(store: store)
        self.titleLabel.text = title
        self.descriptionLabel.text = description
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func addView() {
        super.addView()
        confirmButton.addSubviews {
            loadingIndicatorView
        }
    }

    override func setLayout() {
        MSGLayout.buildLayout {
            contentView.layout
                .center(.toSuperview())
                .horizontal(.toSuperview(), .equal(Metric.horizontalPadding))

            loadingIndicatorView.layout
                .center(.toSuperview())
        }

        MSGLayout.stackedLayout(self.contentView) {
            VStackView(spacing: Metric.spacing) {
                titleLabel

                descriptionLabel

                HStackView(spacing: Metric.spacing) {
                    cancelButton

                    confirmButton
                }
                .distribution(.fillEqually)
            }
            .margin(.all(24))
            .set(\.backgroundColor, .dotori(.background(.card)))
            .set(\.cornerRadius, 16)
        }
    }

    override func bindAction() {
        cancelButton.tapPublisher
            .merge(with: view.tapGesturePublisher().map { _ in })
            .throttle(for: 1, scheduler: RunLoop.main, latest: true)
            .filter { [store] in !store.currentState.isLoading }
            .map { Store.Action.cancelButtonDidTap }
            .sink(receiveValue: store.send(_:))
            .store(in: &subscription)

        confirmButton.tapPublisher
            .filter { [store] in !store.currentState.isLoading }
            .map { Store.Action.confirmButtonDidTap }
            .sink(receiveValue: store.send(_:))
            .store(in: &subscription)
    }

    // swiftlint: disable void_function_in_ternary
    override func bindState() {
        store.state.map(\.isLoading)
            .receive(on: DispatchQueue.main)
            .sink(with: self, receiveValue: { owner, isLoading in
                isLoading
                    ? owner.loadingIndicatorView.startAnimating()
                    : owner.loadingIndicatorView.stopAnimating()

                let title = isLoading ? "" : L10n.Global.confirmButtonTitle
                owner.confirmButton.setTitle(title, for: .normal)
            })
            .store(in: &subscription)
    }
    // swiftlint: enable void_function_in_ternary
}
