import DesignSystem
import Moordinator
import RenewalPasswordFeatureInterface
import RootFeatureInterface
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
        guard let path = path as? SigninRoutePath else { return .none }
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
            return .one(.forwardToParent(with: RootRoutePath.main))

        case let .toast(text, style, duration):
            DotoriToast.makeToast(text: text, style: style, duration: duration)

        default:
            return .none
        }
        return .none
    }
}
