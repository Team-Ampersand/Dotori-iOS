import BaseFeature
import BaseFeatureInterface
import ConfirmationDialogFeatureInterface
import DetailNoticeFeatureInterface
import DWebKit
import Moordinator
import UIKit

final class NoticeMoordinator: Moordinator {
    private let rootVC = UINavigationController()
    private let noticeViewController: any StoredViewControllable
    private let confirmationDialogFactory: any ConfirmationDialogFactory
    private let detailNoticeFactory: any DetailNoticeFactory
    var root: Presentable {
        rootVC
    }

    init(
        noticeViewController: any StoredViewControllable,
        confirmationDialogFactory: any ConfirmationDialogFactory,
        detailNoticeFactory: any DetailNoticeFactory
    ) {
        self.noticeViewController = noticeViewController
        self.confirmationDialogFactory = confirmationDialogFactory
        self.detailNoticeFactory = detailNoticeFactory
    }

    func route(to path: RoutePath) -> MoordinatorContributors {
        guard let path = path.asDotori else { return .none }
        switch path {
        case .notice:
            return coordinateToNotice()

        case let .detailNotice(noticeID):
            return navigateToDetailNotice(noticeID: noticeID)

        case let .confirmationDialog(title, description, confirmAction):
            return presentToConfirmationDialog(title: title, description: description, confirmAction: confirmAction)

        case .dismiss:
            self.rootVC.presentedViewController?.dismiss(animated: true)

        case .pop:
            self.rootVC.popViewController(animated: true)

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
        return .one(
            .contribute(
                withNextPresentable: viewController,
                withNextRouter: viewController.router
            )
        )
    }

    func presentToConfirmationDialog(
        title: String,
        description: String,
        confirmAction: @escaping () async -> Void
    ) -> MoordinatorContributors {
        let viewController = confirmationDialogFactory.makeViewController(
            title: title,
            description: description,
            confirmAction: confirmAction
        )
        self.rootVC.modalPresent(viewController)
        return .one(
            .contribute(
                withNextPresentable: viewController,
                withNextRouter: viewController.router
            )
        )
    }
}
