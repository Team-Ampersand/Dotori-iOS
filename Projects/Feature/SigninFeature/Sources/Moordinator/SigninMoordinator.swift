import Moordinator
import SigninFeatureInterface
import UIKit

final class SigninMoordinator: Moordinator {
    private let rootVC = UINavigationController()
    let router: any Router = SigninRouter()

    var root: Presentable {
        rootVC
    }

    func route(to path: RoutePath) -> MoordinatorContributors {
        guard let path = path as? SigninRoutePath else { return .none }
        switch path {
        case .signin:
            let store = SigninStore(router: router)
            let viewController = SigninViewController(store: store)
            rootVC.setViewControllers([viewController], animated: true)

        default:
            return .none
        }
        return .none
    }
}
