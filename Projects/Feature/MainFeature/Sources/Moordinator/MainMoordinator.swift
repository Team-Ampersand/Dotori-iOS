import UIKit
import Moordinator

final class MainMoordinator: Moordinator {
    private let rootVC = UINavigationController()
    let router: any Router = MainRouter()

    var root: Presentable {
        rootVC
    }

    func route(to path: RoutePath) -> MoordinatorContributors {
        return .none
    }
}
