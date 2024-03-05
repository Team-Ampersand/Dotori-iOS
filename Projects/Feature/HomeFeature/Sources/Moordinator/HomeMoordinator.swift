import BaseFeature
import BaseFeatureInterface
import ConfirmationDialogFeatureInterface
import DWebKit
import InputDialogFeatureInterface
import Localization
import Moordinator
import MyViolationListFeatureInterface
import ProfileImageFeatureInterface
import TimerInterface
import UIKit
import UIKitUtil

final class HomeMoordinator: Moordinator {
    private let rootVC = UINavigationController()
    private let homeViewController: any StoredViewControllable
    private let confirmationDialogFactory: any ConfirmationDialogFactory
    private let myViolationListFactory: any MyViolationListFactory
    private let profileImageFactory: any ProfileImageFactory
    private let inputDialogFactory: any InputDialogFactory
    var root: Presentable {
        rootVC
    }

    init(
        homeViewController: any StoredViewControllable,
        confirmationDialogFactory: any ConfirmationDialogFactory,
        myViolationListFactory: any MyViolationListFactory,
        profileImageFactory: any ProfileImageFactory,
        inputDialogFactory: any InputDialogFactory
    ) {
        self.homeViewController = homeViewController
        self.confirmationDialogFactory = confirmationDialogFactory
        self.myViolationListFactory = myViolationListFactory
        self.profileImageFactory = profileImageFactory
        self.inputDialogFactory = inputDialogFactory
    }

    // swiftlint: disable cyclomatic_complexity
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

        case .profileImage:
            return presentToProfileImage()

        case let .confirmationDialog(title, description, confirmAction):
            return presentToConfirmationDialog(title: title, description: description, confirmAction: confirmAction)

        case .dismiss:
            self.rootVC.presentedViewController?.dismiss(animated: true)

        case .signin:
            return .end(DotoriRoutePath.signin)

        case let .inputDialog(title, placeholder, inputType, confirmAction):
            return presentToInputDialog(
                title: title,
                placeholder: placeholder,
                inputType: inputType,
                confirmAction: confirmAction
            )

        default:
            return .none
        }
        return .none
    }
    // swiftlint: enable cyclomatic_complexity
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
            withNextRouter: viewController.router
        ))
    }

    func presentToProfileImage() -> MoordinatorContributors {
        let viewController = profileImageFactory.makeViewController()
        self.rootVC.topViewController?.modalPresent(viewController)
        return .one(.contribute(
            withNextPresentable: viewController,
            withNextRouter: viewController.router
        ))
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

    func presentToAlert(
        title: String?,
        message: String?,
        style: UIAlertController.Style,
        actions: [UIAlertAction]
    ) -> MoordinatorContributors {
        let style: UIAlertController.Style = (style == .actionSheet && UIDevice.current.userInterfaceIdiom == .pad)
            ? .alert
            : style
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        if !actions.isEmpty {
            actions.forEach(alert.addAction(_:))
        } else {
            alert.addAction(.init(title: L10n.Global.confirmButtonTitle, style: .default))
        }
        self.rootVC.topViewController?.present(alert, animated: true)
        return .none
    }

    func presentToInputDialog(
        title: String,
        placeholder: String,
        inputType: DialogInputType,
        confirmAction: @escaping (String) async -> Void
    ) -> MoordinatorContributors {
        let viewController = inputDialogFactory.makeViewController(
            title: title,
            placeholder: placeholder,
            inputType: inputType,
            confirmAction: confirmAction
        )
        self.rootVC.topViewController?.modalPresent(viewController)
        return .one(
            .contribute(
                withNextPresentable: viewController,
                withNextRouter: viewController.router
            )
        )
    }
}
