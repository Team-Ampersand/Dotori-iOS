import BaseFeature
import UIKit

public protocol ConfirmationDialogFactory {
    func makeViewController(
        title: String,
        description: String,
        confirmAction: @escaping () async -> Void
    ) -> any StoredViewControllable
}
