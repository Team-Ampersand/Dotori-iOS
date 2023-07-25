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

        case let .alert(title, message, style, actions):
            return presentToAlert(title: title, message: message, style: style, actions: actions)

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

    func presentToAlert(
        title: String?,
        message: String?,
        style: UIAlertController.Style,
        actions: [UIAlertAction]
    ) -> MoordinatorContributors {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        if !actions.isEmpty {
            actions.forEach(alert.addAction(_:))
        } else {
            alert.addAction(.init(title: "확인", style: .default))
        }
        self.rootVC.topViewController?.present(alert, animated: true)
        return .none
    }
}
