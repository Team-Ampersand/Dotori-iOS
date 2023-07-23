import UIKit

public protocol ConfirmationDialogFactory {
    func makeViewController(
        title: String,
        description: String,
        confirmAction: @escaping () -> Void
    ) -> UIViewController
}
