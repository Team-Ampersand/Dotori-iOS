import BaseFeature
import Moordinator
import UIKit

final class HomeMoordinator: Moordinator {
    private let rootVC = UIViewController()

    var root: Presentable {
        rootVC
    }

    func route(to path: RoutePath) -> MoordinatorContributors {
        guard let path = path.asDotori else { return .none }
        switch path {
        case .main:
            return coordinateToHome()

        default:
            return .none
        }
        return .none
    }
}

private extension HomeMoordinator {
    func coordinateToHome() -> MoordinatorContributors {
        return .none
    }
}
