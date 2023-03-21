import Moordinator
import SigninFeatureInterface
import SignupFeatureInterface
import UIKit

final class SigninMoordinator: Moordinator {
    private let rootVC = UINavigationController()
    let router: any Router
    private let signinViewController: SigninViewController
    private let signupFactory: any SignupFactory

    init(
        router: SigninRouter,
        signinViewController: SigninViewController,
        signupFactory: any SignupFactory
    ) {
        self.router = router
        self.signinViewController = signinViewController
        self.signupFactory = signupFactory
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

        default:
            return .none
        }
        return .none
    }
}
