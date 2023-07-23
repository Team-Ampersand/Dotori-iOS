import UIKit

final class ConfirmationDialogFactoryImpl: ConfirmationDialogFactory {
    func makeViewController(title: String, description: String) -> UIViewController {
        let store = ConfirmationDialogStore()
        return ConfirmationDialogViewController(
            title: title,
            description: description,
            store: store
        )
    }
}
