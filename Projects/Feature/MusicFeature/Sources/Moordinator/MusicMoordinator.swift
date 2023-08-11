import BaseFeature
import Localization
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

        case .youtube:
            return openYoutube()

        case let .youtubeByID(id):
            return openYoutube(id: id)

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
        let style: UIAlertController.Style = (style == .actionSheet && UIDevice.current.userInterfaceIdiom == .pad)
            ? .alert
            : style
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        if !actions.isEmpty {
            actions.forEach(alert.addAction(_:))
        } else {
            alert.addAction(.init(title: L10n.Global.confirmButtonTitle, style: .default))
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

    func openYoutube() -> MoordinatorContributors {
        guard let url = URL(string: "youtube://") else { return .none }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else if let webURL = URL(string: "https://youtube.com") {
            UIApplication.shared.open(webURL)
        }
        return .none
    }

    func openYoutube(id: String) -> MoordinatorContributors {
        guard let url = URL(string: "youtube://\(id)") else { return .none }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else if let webURL = URL(string: "https://youtube.com/watch?v=\(id)") {
            UIApplication.shared.open(webURL)
        }
        return .none
    }
}
