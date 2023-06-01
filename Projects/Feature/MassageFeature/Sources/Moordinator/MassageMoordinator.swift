import BaseFeature
import DWebKit
import Moordinator
import UIKit

final class MassageMoordinator: Moordinator {
    private let rootVC = UINavigationController()

    var root: Presentable {
        rootVC
    }

    func route(to path: RoutePath) -> MoordinatorContributors {
        guard let path = path.asDotori else { return .none }
        switch path {
        case .massage:
            return coordinateToMassage()

        default:
            return .none
        }
        return .none
    }
}

private extension MassageMoordinator {
    func coordinateToMassage() -> MoordinatorContributors {
        let noticeWebViewController = DWebViewController(urlString: "https://www.dotori-gsm.com/massage")
        self.rootVC.setViewControllers([noticeWebViewController], animated: true)
        return .none
    }
}
