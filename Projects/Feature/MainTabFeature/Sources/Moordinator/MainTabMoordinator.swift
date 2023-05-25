import UIKit
 import Moordinator

final class MainTabMoordinator: Moordinator {
    private let rootVC = MainTabbarController()
    
    var root: Presentable {
        rootVC
    }
    
    func route(to path: RoutePath) -> MoordinatorContributors {
        return .none
    }
}
