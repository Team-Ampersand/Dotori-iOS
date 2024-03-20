import BaseFeature
import BaseFeatureInterface
import DWebKit
import Localization
import Moordinator
import ProfileImageFeatureInterface
import UIKit
import UIKitUtil
import YPImagePicker

final class ProfileMoordinator: Moordinator {
    private let rootVC = UINavigationController()

    private let ypImageFactory: any YPImageFactory
    var root: Presentable {
        rootVC
    }

    init(
        ypImageFactory: any YPImageFactory
    ) {
        self.ypImageFactory = ypImageFactory
    }

    // swiftlint: disable cyclomatic_complexity
    func route(to path: RoutePath) -> MoordinatorContributors {
        guard let path = path.asDotori else { return .none }
        switch path {
        case .imagePicker:
            return presentToYPImagePicker()
        default:
            return .none
        }
        return .none
    }
    // swiftlint: enable cyclomatic_complexity
}

private extension ProfileMoordinator {
    func presentToYPImagePicker() -> MoordinatorContributors {
        let viewController = ypImageFactory.makeViewController()
        self.rootVC.topViewController?.modalPresent(viewController)
        return .one(.contribute(
            withNextPresentable: viewController,
            withNextRouter: viewController.router
        ))
    }
}
