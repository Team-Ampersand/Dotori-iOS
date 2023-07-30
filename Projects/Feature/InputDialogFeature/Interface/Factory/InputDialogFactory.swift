import BaseFeatureInterface
import UIKit

public protocol InputDialogFactory {
    func makeViewController(
        title: String,
        placeholder: String,
        inputType: DialogInputType,
        confirmAction: @escaping (String) async -> Void
    ) -> any RoutedViewControllable
}
