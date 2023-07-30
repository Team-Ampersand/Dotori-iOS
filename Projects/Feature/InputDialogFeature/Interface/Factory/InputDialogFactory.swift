import BaseFeatureInterface
import UIKit

public protocol InputDialogFactory {
    func makeViewController(
        title: String,
        placeholder: String,
        inputType: InputType,
        confirmAction: @escaping (String) async -> Void
    ) -> any RoutedViewControllable
}
