import BaseFeature
import DWebKit
import Moordinator
import UIKit

final class MassageMoordinator: Moordinator {
    private let rootVC = UINavigationController()
    private let massageViewController: any StoredViewControllable
    var root: Presentable {
        rootVC
    }

    init(massageViewController: any StoredViewControllable) {
        self.massageViewController = massageViewController
    }

    func route(to path: RoutePath) -> MoordinatorContributors {
        guard let path = path.asDotori else { return .none }
        switch path {
        case .massage:
            return coordinateToMassage()

        default:
            return .none
        }
        return .none
    }
}

private extension MassageMoordinator {
    func coordinateToMassage() -> MoordinatorContributors {
        self.rootVC.setViewControllers([self.massageViewController], animated: true)
        return .one(
            .contribute(
                withNextPresentable: self.massageViewController,
                withNextRouter: self.massageViewController.store
            )
        )
    }
}
