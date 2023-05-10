import UIKit
import Moordinator

final class MainMoordinator: Moordinator {
    private let rootVC = UINavigationController()

    var root: Presentable {
        rootVC
    }

    func route(to path: RoutePath) -> MoordinatorContributors {
        return .none
    }
}
