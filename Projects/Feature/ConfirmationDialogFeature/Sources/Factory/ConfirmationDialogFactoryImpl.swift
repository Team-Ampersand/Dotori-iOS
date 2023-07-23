import UIKit

final class ConfirmationDialogFactoryImpl: ConfirmationDialogFactory {
    func makeViewController() -> UIViewController {
        let store = ConfirmationDialogStore()
        return ConfirmationDialogViewController(store: store)
    }
}
