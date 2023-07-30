import BaseFeature
import BaseFeatureInterface
import CombineUtility
import DesignSystem
import InputDialogFeatureInterface
import Localization
import MSGLayout
import UIKit

final class InputDialogViewController: BaseStoredModalViewController<InputDialogStore> {
    private let dialogTitleLabel = DotoriLabel(font: .subtitle1)
    private let inputTextField = DotoriSimpleTextField()
    private let cancelButton = DotoriOutlineButton(text: L10n.Global.cancelButtonTitle)
    private let confirmButton = DotoriButton(text: L10n.Global.confirmButtonTitle)
    private let loadingIndicatorView = UIActivityIndicatorView(style: .medium)

    init(
        title: String,
        placeholder: String,
        store: InputDialogStore
    ) {
        super.init(store: store)
        self.dialogTitleLabel.text = title
        self.inputTextField.placeholder = placeholder
    }

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
                .horizontal(.toSuperview(), .equal(40))

            loadingIndicatorView.layout
                .center(.toSuperview())
        }

        MSGLayout.stackedLayout(self.contentView) {
            VStackView(spacing: 16) {
                VStackView(spacing: 8) {
                    dialogTitleLabel

                    inputTextField
                }

                HStackView(spacing: 8) {
                    cancelButton

                    confirmButton
                }
                .distribution(.fillEqually)
            }
            .margin(.all(24))
        }
    }

    override func bindAction() {
        inputTextField.textPublisher
            .map(Store.Action.updateInputText)
            .sink(receiveValue: store.send(_:))
            .store(in: &subscription)

        view.tapGesturePublisher()
            .map { _ in Store.Action.dimmedBackgroundViewDidTap }
            .sink(receiveValue: store.send(_:))
            .store(in: &subscription)

        cancelButton.tapPublisher
            .map { Store.Action.cancelButtonDidTap }
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
            .map(\.inputType)
            .removeDuplicates()
            .map(\.keyboardType)
            .assign(to: \.keyboardType, on: inputTextField)
            .store(in: &subscription)

        sharedState
            .map(\.inputText)
            .removeDuplicates()
            .map(Optional.init)
            .assign(to: \.text, on: inputTextField)
            .store(in: &subscription)

        sharedState
            .map(\.isLoading)
            .removeDuplicates()
            .sink(with: self, receiveValue: { owner, isLoading in
                isLoading
                ? owner.loadingIndicatorView.startAnimating()
                : owner.loadingIndicatorView.stopAnimating()

                let title = isLoading ? "" : L10n.Global.confirmButtonTitle
                owner.confirmButton.setTitle(title, for: .normal)
            })
            .store(in: &subscription)
    }
}

private extension DialogInputType {
    var keyboardType: UIKeyboardType {
        switch self {
        case .number: return .numberPad
        case .text: return .`default`
        }
    }
}
