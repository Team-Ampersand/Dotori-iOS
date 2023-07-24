import BaseFeature
import DWebKit
import UIKit
import Moordinator

final class SelfStudyMoordinator: Moordinator {
    private let rootVC = UINavigationController()
    private let selfStudyViewController: any StoredViewControllable

    var root: Presentable {
        rootVC
    }

    init(selfStudyViewController: any StoredViewControllable) {
        self.selfStudyViewController = selfStudyViewController
    }

    func route(to path: RoutePath) -> MoordinatorContributors {
        guard let path = path.asDotori else { return .none }
        switch path {
        case .selfStudy:
            return coordinateToSelfStudy()

        default:
            return .none
        }
        return .none
    }
}

private extension SelfStudyMoordinator {
    func coordinateToSelfStudy() -> MoordinatorContributors {
        self.rootVC.setViewControllers([self.selfStudyViewController], animated: true)
        return .one(
            .contribute(
                withNextPresentable: self.selfStudyViewController,
                withNextRouter: self.selfStudyViewController.store
            )
        )
    }
}
