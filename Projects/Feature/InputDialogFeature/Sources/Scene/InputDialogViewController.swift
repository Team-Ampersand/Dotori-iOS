import BaseFeature
import DesignSystem
import Localization
import MSGLayout
import UIKit

final class InputDialogViewController: BaseStoredModalViewController<InputDialogStore> {
    private let dialogTitleLabel = DotoriLabel(font: .subtitle1)
    private let inputTextField = DotoriSimpleTextField()
    private let cancelButton = DotoriOutlineButton(text: L10n.Global.cancelButtonTitle)
    private let confirmButton = DotoriButton(text: L10n.Global.confirmButtonTitle)

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

    override func setLayout() {
        MSGLayout.buildLayout {
            contentView.layout
                .center(.toSuperview())
                .horizontal(.toSuperview(), .equal(40))
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
}
