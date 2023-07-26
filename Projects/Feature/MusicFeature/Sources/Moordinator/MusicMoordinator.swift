import BaseFeature
import DWebKit
import Moordinator
import UIKit

final class MusicMoordinator: Moordinator {
    private let rootVC = UINavigationController()
    private let musicViewController: any StoredViewControllable
    var root: Presentable {
        rootVC
    }

    init(musicViewController: any StoredViewControllable) {
        self.musicViewController = musicViewController
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
        self.rootVC.setViewControllers([self.musicViewController], animated: true)
        return .one(
            .contribute(
                withNextPresentable: self.musicViewController,
                withNextRouter: self.musicViewController.store
            )
        )
    }
}
