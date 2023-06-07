import BaseFeature
import DWebKit
import Moordinator
import UIKit

final class MusicMoordinator: Moordinator {
    private let rootVC = UINavigationController()

    var root: Presentable {
        rootVC
    }

    func route(to path: RoutePath) -> MoordinatorContributors {
        guard let path = path.asDotori else { return .none }
        switch path {
        case .music:
            return coordinateToMusic()

        default:
            return .none
        }
        return .none
    }
}

private extension MusicMoordinator {
    func coordinateToMusic() -> MoordinatorContributors {
        let musicWebViewController = DWebViewController(urlString: "https://www.dotori-gsm.com/song")
        self.rootVC.setViewControllers([musicWebViewController], animated: true)
        return .none
    }
}
