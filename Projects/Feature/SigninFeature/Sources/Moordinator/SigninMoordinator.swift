import Moordinator
import SigninFeatureInterface
import UIKit

final class SigninMoordinator: Moordinator {
    private let rootVC = UINavigationController()
    let router: any Router
    let signinViewController: SigninViewController

    init(
        router: SigninRouter,
        signinViewController: SigninViewController
    ) {
        self.router = router
        self.signinViewController = signinViewController
    }

    var root: Presentable {
        rootVC
    }

    func route(to path: RoutePath) -> MoordinatorContributors {
        guard let path = path as? SigninRoutePath else { return .none }
        switch path {
        case .signin:
            rootVC.setViewControllers([signinViewController], animated: true)

        default:
            return .none
        }
        return .none
    }
}
