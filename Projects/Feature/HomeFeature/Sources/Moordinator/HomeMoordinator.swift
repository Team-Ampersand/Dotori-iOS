import BaseFeature
import DWebKit
import Moordinator
import UIKit

final class HomeMoordinator: Moordinator {
    private let rootVC = UINavigationController()

    var root: Presentable {
        rootVC
    }

    func route(to path: RoutePath) -> MoordinatorContributors {
        guard let path = path.asDotori else { return .none }
        switch path {
        case .home:
            return coordinateToHome()

        default:
            return .none
        }
        return .none
    }
}

private extension HomeMoordinator {
    func coordinateToHome() -> MoordinatorContributors {
        let homeWebViewController = DWebViewController(urlString: "https://dotori-gsm.com/home")
        self.rootVC.setViewControllers([homeWebViewController], animated: true)
        return .none
    }
}
