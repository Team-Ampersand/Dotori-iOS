import BaseFeatureInterface
import ImagePickerFeatureInterface
import Moordinator
import UIKit
import UserDomainInterface

struct ImagePickerFactoryImpl: ImagePickerFactory {
    func makeViewController(completion: @escaping (Data) -> Void) -> any RoutedViewControllable {
        let imagePickerController = ImagePickerController(closure: completion)
        return imagePickerController
    }
}
