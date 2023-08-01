import BaseFeature
import DWebKit
import FilterSelfStudyFeatureInterface
import Moordinator
import UIKit

final class SelfStudyMoordinator: Moordinator {
    private let rootVC = UINavigationController()
    private let selfStudyViewController: any StoredViewControllable
    private let filterSelfStudyFactory: any FilterSelfStudyFactory

    var root: Presentable {
        rootVC
    }

    init(
        selfStudyViewController: any StoredViewControllable,
        filterSelfStudyFactory: any FilterSelfStudyFactory
    ) {
        self.selfStudyViewController = selfStudyViewController
        self.filterSelfStudyFactory = filterSelfStudyFactory
    }

    func route(to path: RoutePath) -> MoordinatorContributors {
        guard let path = path.asDotori else { return .none }
        switch path {
        case .selfStudy:
            return coordinateToSelfStudy()

        case let .filterSelfStudy(confirmAction):
            return presentToFilterSelfStudy(confirmAction: confirmAction)

        case .dismiss:
            self.rootVC.presentedViewController?.dismiss(animated: true)

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

    func presentToFilterSelfStudy(
        confirmAction: @escaping (
            _ name: String?,
            _ grade: Int?,
            _ `class`: Int?,
            _ gender: String?
        ) -> Void
    ) -> MoordinatorContributors {
        let filterSelfStudyViewController = self.filterSelfStudyFactory.makeViewController(
            confirmAction: confirmAction
        )
        self.rootVC.topViewController?.modalPresent(filterSelfStudyViewController, animated: false)
        return .one(
            .contribute(
                withNextPresentable: filterSelfStudyViewController,
                withNextRouter: filterSelfStudyViewController.router
            )
        )
    }
}
