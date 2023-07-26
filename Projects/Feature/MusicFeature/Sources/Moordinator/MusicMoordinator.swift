import BaseFeature
import Moordinator
import ProposeMusicFeature
import UIKit
import UIKitUtil

final class MusicMoordinator: Moordinator {
    private let rootVC = UINavigationController()
    private let musicViewController: any StoredViewControllable
    private let proposeMusicFactory: any ProposeMusicFactory
    var root: Presentable {
        rootVC
    }

    init(
        musicViewController: any StoredViewControllable,
        proposeMusicFactory: any ProposeMusicFactory
    ) {
        self.musicViewController = musicViewController
        self.proposeMusicFactory = proposeMusicFactory
    }

    func route(to path: RoutePath) -> MoordinatorContributors {
        guard let path = path.asDotori else { return .none }
        switch path {
        case .music:
            return coordinateToMusic()

        case let .alert(title, message, style, actions):
            return presentToAlert(title: title, message: message, style: style, actions: actions)

        case .proposeMusic:
            return presentToProposeMusic()

        case .dismiss:
            return dismiss()

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

    func presentToProposeMusic() -> MoordinatorContributors {
        let viewController = proposeMusicFactory.makeViewController()
        self.rootVC.topViewController?.modalPresent(viewController)
        return .one(
            .contribute(
                withNextPresentable: viewController,
                withNextRouter: viewController.store
            )
        )
    }

    func dismiss() -> MoordinatorContributors {
        self.rootVC.presentedViewController?.dismiss(animated: true)
        return .none
    }
}
