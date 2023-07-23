import BaseFeature
import DesignSystem
import Localization
import MSGLayout
import UIKit

final class ConfirmationDialogViewController: BaseModalViewController<ConfirmationDialogStore> {
    private enum Metric {
        static let horizontalPadding: CGFloat = 40
        static let spacing: CGFloat = 8
    }
    private let titleLabel = DotoriLabel(font: .subtitle1)
    private let descriptionLabel = DotoriLabel(textColor: .neutral(.n20), font: .body2)
        .set(\.numberOfLines, 2)
    private let cancelButton = DotoriButton(text: L10n.Global.cancelButtonTitle)
    private let confirmButton = DotoriOutlineButton(text: L10n.Global.confirmButtonTitle)

    init(
        title: String,
        description: String,
        store: ConfirmationDialogStore
    ) {
        super.init(store: store)
        titleLabel.text = title
        descriptionLabel.text = description
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setLayout() {
        MSGLayout.buildLayout {
            contentView.layout
                .center(.toSuperview())
                .horizontal(.toSuperview(), .equal(Metric.horizontalPadding))
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
        view.backgroundColor = .gray
    }
}
