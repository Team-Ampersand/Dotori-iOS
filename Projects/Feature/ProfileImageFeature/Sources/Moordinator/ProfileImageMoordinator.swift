import BaseFeature
import BaseFeatureInterface
import DWebKit
import ImagePickerFeatureInterface
import Localization
import Moordinator
import ProfileImageFeatureInterface
import UIKit
import UIKitUtil
import YPImagePicker

final class ProfileImageMoordinator: Moordinator {
    private let rootVC = UINavigationController()
    private let profileImageController: any StoredViewControllable
    private let imagePickerFactory: any ImagePickerFactory

    var root: Presentable {
        rootVC
    }

    init(
        profileImageController: any StoredViewControllable,
        imagePickerFactory: any ImagePickerFactory
    ) {
        self.profileImageController = profileImageController
        self.imagePickerFactory = imagePickerFactory
    }

    // swiftlint: disable cyclomatic_complexity
    func route(to path: RoutePath) -> MoordinatorContributors {
        guard let path = path.asDotori else { return .none }
        switch path {
        case let .imagePicker(completion):
            return presentToImagePicker(completion: completion)
        default:
            return .none
        }
        return .none
    }
    // swiftlint: enable cyclomatic_complexity
}

private extension ProfileImageMoordinator {
    func presentToImagePicker(completion: @escaping (Data) -> Void) -> MoordinatorContributors {
        let viewController = imagePickerFactory.makeViewController(completion: completion)
        self.rootVC.topViewController?.modalPresent(viewController)
        return .one(.contribute(
            withNextPresentable: viewController,
            withNextRouter: viewController.router
        ))
    }
}
