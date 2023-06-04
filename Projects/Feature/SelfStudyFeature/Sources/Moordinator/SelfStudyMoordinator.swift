import BaseFeature
import DWebKit
import UIKit
import Moordinator

final class SelfStudyMoordinator: Moordinator {
    private let rootVC = UINavigationController()

    var root: Presentable {
        rootVC
    }

    func route(to path: RoutePath) -> MoordinatorContributors {
        guard let path = path.asDotori else { return .none }
        switch path {
        case .selfStudy:
            return coordinateToSelfStudy()

        default:
            return .none
        }
        return .none
    }
}

private extension SelfStudyMoordinator {
    func coordinateToSelfStudy() -> MoordinatorContributors {
        let selfStudyWebViewController = DWebViewController(urlString: "https://www.dotori-gsm.com/selfstudy")
        self.rootVC.setViewControllers([selfStudyWebViewController], animated: true)
        return .none
    }
}
