import BaseFeature
import DWebKit
import DetailNoticeFeature
import Moordinator
import UIKit

final class NoticeMoordinator: Moordinator {
    private let rootVC = UINavigationController()
    private let noticeViewController: any StoredViewControllable
    private let detailNoticeFactory: any DetailNoticeFactory
    var root: Presentable {
        rootVC
    }

    init(
        noticeViewController: any StoredViewControllable,
        detailNoticeFactory: any DetailNoticeFactory
    ) {
        self.noticeViewController = noticeViewController
        self.detailNoticeFactory = detailNoticeFactory
    }

    func route(to path: RoutePath) -> MoordinatorContributors {
        guard let path = path.asDotori else { return .none }
        switch path {
        case .notice:
            return coordinateToNotice()

        case let .detailNotice(noticeID):
            return navigateToDetailNotice(noticeID: noticeID)

        default:
            return .none
        }
        return .none
    }
}

private extension NoticeMoordinator {
    func coordinateToNotice() -> MoordinatorContributors {
        self.rootVC.setViewControllers([self.noticeViewController], animated: true)
        return .one(
            .contribute(
                withNextPresentable: self.noticeViewController,
                withNextRouter: self.noticeViewController.store
            )
        )
    }

    func navigateToDetailNotice(noticeID: Int) -> MoordinatorContributors {
        let viewController = detailNoticeFactory.makeViewController(noticeID: noticeID)
        self.rootVC.pushViewController(viewController, animated: true)
        return .none
    }
}
