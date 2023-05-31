import BaseFeature
import DWebKit
import UIKit
import Moordinator

final class NoticeMoordinator: Moordinator {
    private let rootVC = UINavigationController()

    var root: Presentable {
        rootVC
    }

    func route(to path: RoutePath) -> MoordinatorContributors {
        guard let path = path.asDotori else { return .none }
        switch path {
        case .notice:
            return coordinateToNotice()

        default:
            return .none
        }
        return .none
    }
}

private extension NoticeMoordinator {
    func coordinateToNotice() -> MoordinatorContributors {
        let noticeWebViewController = DWebViewController(urlString: "https://www.dotori-gsm.com/notice")
        self.rootVC.setViewControllers([noticeWebViewController], animated: true)
        return .none
    }
}
