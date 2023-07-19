import BaseFeature
import DWebKit
import UIKit
import Moordinator

final class NoticeMoordinator: Moordinator {
    private let rootVC = UINavigationController()
    private let noticeViewController: any StoredViewControllable
    var root: Presentable {
        rootVC
    }

    init(noticeViewController: any StoredViewControllable) {
        self.noticeViewController = noticeViewController
    }

    func route(to path: RoutePath) -> MoordinatorContributors {
        guard let path = path.asDotori else { return .none }
        switch path {
        case .notice:
            return coordinateToNotice()

        default:
            return .none
        }
        return .none
    }
}

private extension NoticeMoordinator {
    func coordinateToNotice() -> MoordinatorContributors {
        self.rootVC.setViewControllers([self.noticeViewController], animated: true)
        return .one(.contribute(withNextPresentable: self.noticeViewController, withNextRouter: self.noticeViewController.store))
    }
}
