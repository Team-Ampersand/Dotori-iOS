import BaseFeature
import ConfirmationDialogFeature
import DWebKit
import Moordinator
import MyViolationListFeature
import TimerInterface
import UIKit
import UIKitUtil

final class HomeMoordinator: Moordinator {
    private let rootVC = UINavigationController()
    private let homeViewController: any StoredViewControllable
    private let confirmationDialogFactory: any ConfirmationDialogFactory
    private let myViolationListFactory: any MyViolationListFactory
    var root: Presentable {
        rootVC
    }

    init(
        homeViewController: any StoredViewControllable,
        confirmationDialogFactory: any ConfirmationDialogFactory,
        myViolationListFactory: any MyViolationListFactory
    ) {
        self.homeViewController = homeViewController
        self.confirmationDialogFactory = confirmationDialogFactory
        self.myViolationListFactory = myViolationListFactory
    }

    func route(to path: RoutePath) -> MoordinatorContributors {
        guard let path = path.asDotori else { return .none }
        switch path {
        case .home:
            return coordinateToHome()

        case let .alert(title, message, style, actions):
            return presentToAlert(title: title, message: message, style: style, actions: actions)

        case .selfStudy:
            return .one(.forwardToParent(with: DotoriRoutePath.selfStudy))

        case .massage:
            return .one(.forwardToParent(with: DotoriRoutePath.massage))

        case .myViolationList:
            return presentToMyViolationList()

        case let .confirmationDialog(title, description, confirmAction):
            let viewController = confirmationDialogFactory.makeViewController(
                title: title,
                description: description,
                confirmAction: confirmAction
            )
            self.rootVC.modalPresent(viewController)
            return .one(
                .contribute(
                    withNextPresentable: viewController,
                    withNextRouter: viewController.store
                )
            )

        case .dismiss:
            self.rootVC.presentedViewController?.dismiss(animated: true)

        default:
            return .none
        }
        return .none
    }
}

private extension HomeMoordinator {
    func coordinateToHome() -> MoordinatorContributors {
        self.rootVC.setViewControllers([self.homeViewController], animated: true)
        return .one(.contribute(
            withNextPresentable: self.homeViewController,
            withNextRouter: self.homeViewController.store
        ))
    }

    func presentToMyViolationList() -> MoordinatorContributors {
        let viewController = myViolationListFactory.makeViewController()
        self.rootVC.topViewController?.modalPresent(viewController)
        return .one(.contribute(
            withNextPresentable: viewController,
            withNextRouter: viewController.store
        ))
    }

    func presentToAlert(
        title: String?,
        message: String?,
        style: UIAlertController.Style,
        actions: [UIAlertAction]
    ) -> MoordinatorContributors {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        if !actions.isEmpty {
            actions.forEach(alert.addAction(_:))
        } else {
            alert.addAction(.init(title: "확인", style: .default))
        }
        self.rootVC.topViewController?.present(alert, animated: true)
        return .none
    }
}
