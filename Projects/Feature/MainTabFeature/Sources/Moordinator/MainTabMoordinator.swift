import BaseFeature
import UIKit
import Moordinator

final class MainTabMoordinator: Moordinator {
    private let rootVC = MainTabbarController()

    var root: Presentable {
        rootVC
    }

    func route(to path: RoutePath) -> MoordinatorContributors {
        guard let path = path.asDotori else { return .none }
        switch path {
        case .main:
            return coordinateToMainTab()

        default:
            return .none
        }
        return .none
    }
}

private extension MainTabMoordinator {
    func coordinateToMainTab() -> MoordinatorContributors {
        return .none
    }
}
