import BaseFeatureInterface
import Foundation

public protocol ImagePickerFactory {
    func makeViewController(
        completion: @escaping (Data) -> Void
    ) -> any RoutedViewControllable
}
