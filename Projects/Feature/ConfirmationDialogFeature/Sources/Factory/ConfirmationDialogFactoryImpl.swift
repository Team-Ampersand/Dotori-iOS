import BaseFeature
import UIKit

final class ConfirmationDialogFactoryImpl: ConfirmationDialogFactory {
    func makeViewController(
        title: String,
        description: String,
        confirmAction: @escaping () async -> Void
    ) -> any StoredViewControllable {
        let store = ConfirmationDialogStore(confirmAction: confirmAction)
        return ConfirmationDialogViewController(
            title: title,
            description: description,
            store: store
        )
    }
}
