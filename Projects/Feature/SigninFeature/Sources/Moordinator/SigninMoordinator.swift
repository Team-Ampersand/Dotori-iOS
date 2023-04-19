import BaseFeature
import DesignSystem
import Moordinator
import RenewalPasswordFeatureInterface
import SigninFeatureInterface
import SignupFeatureInterface
import UIKit

final class SigninMoordinator: Moordinator {
    private let rootVC = UINavigationController()
    let router: any Router
    private let signinViewController: SigninViewController
    private let signupFactory: any SignupFactory
    private let renewalPasswordFactory: any RenewalPasswordFactory

    init(
        router: SigninRouter,
        signinViewController: SigninViewController,
        signupFactory: any SignupFactory,
        renewalPasswordFactory: any RenewalPasswordFactory
    ) {
        self.router = router
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

        case .signup:
            let viewController = signupFactory.makeViewController(router: router)
            rootVC.pushViewController(viewController, animated: true)
            return .one(.contribute(viewController))

        case .renewalPassword:
            let viewController = renewalPasswordFactory.makeViewController(router: router)
            rootVC.pushViewController(viewController, animated: true)
            return .one(.contribute(viewController))

        case .main:
            return .one(.forwardToParent(with: DotoriRoutePath.main))

        default:
            return .none
        }
        return .none
    }
}
