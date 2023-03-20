import UIKit
import Moordinator

final class SigninMoordinator: Moordinator {
    private let rootVC = UINavigationController()
    let router: any Router = SigninRouter()

    var root: Presentable {
        rootVC
    }

    func route(to path: RoutePath) -> MoordinatorContributors {
        return .none
    }
}
