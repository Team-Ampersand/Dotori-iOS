import BaseFeature
import DesignSystem
import Moordinator
import RenewalPasswordFeature
import SignupFeature
import UIKit

final class SigninMoordinator: Moordinator {
    private let rootVC = UINavigationController()
    private let signinViewController: SigninViewController
    private let signupFactory: any SignupFactory
    private let renewalPasswordFactory: any RenewalPasswordFactory

    init(
        signinViewController: SigninViewController,
        signupFactory: any SignupFactory,
        renewalPasswordFactory: any RenewalPasswordFactory
    ) {
        self.signinViewController = signinViewController
        self.signupFactory = signupFactory
        self.renewalPasswordFactory = renewalPasswordFactory
    }

    var root: Presentable {
        rootVC
    }

    func route(to path: RoutePath) -> MoordinatorContributors {
        guard let path = path.asDotori else { return .none }
        switch path {
        case .signin:
            rootVC.setViewControllers([signinViewController], animated: true)
            return .one(
                .contribute(
                    withNextPresentable: signinViewController,
                    withNextRouter: signinViewController.store
                )
            )

        case .signup:
            let viewController = signupFactory.makeViewController()
            rootVC.pushViewController(viewController, animated: true)
            return .one(.contribute(withNextPresentable: viewController))

        case .renewalPassword:
            let viewController = renewalPasswordFactory.makeViewController()
            rootVC.pushViewController(viewController, animated: true)
            return .one(.contribute(withNextPresentable: viewController))

        case .main:
            return .one(.forwardToParent(with: DotoriRoutePath.main))

        default:
            return .none
        }
        return .none
    }
}
