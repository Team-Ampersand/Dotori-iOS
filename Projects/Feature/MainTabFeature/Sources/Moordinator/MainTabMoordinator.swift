import BaseFeature
import HomeFeature
import MassageFeature
import Moordinator
import MusicFeature
import NoticeFeature
import SelfStudyFeature
import UIKit

final class MainTabMoordinator: Moordinator {
    private let rootVC = MainTabbarController()
    private let homeFactory: any HomeFactory
    private let noticeFactory: any NoticeFactory
    private let selfStudyFactory: any SelfStudyFactory
    private let massageFactory: any MassageFactory
    private let musicFactory: any MusicFactory

    init(
        homeFactory: any HomeFactory,
        noticeFactory: any NoticeFactory,
        selfStudyFactory: any SelfStudyFactory,
        massageFactory: any MassageFactory,
        musicFactory: any MusicFactory
    ) {
        self.homeFactory = homeFactory
        self.noticeFactory = noticeFactory
        self.selfStudyFactory = selfStudyFactory
        self.massageFactory = massageFactory
        self.musicFactory = musicFactory
    }

    var root: Presentable {
        rootVC
    }

    func route(to path: RoutePath) -> MoordinatorContributors {
        guard let path = path.asDotori else { return .none }
        switch path {
        case .main:
            return coordinateToMainTab()

        case .selfStudy:
            rootVC.selectedIndex = 2

        case .massage:
            rootVC.selectedIndex = 3

        case .signin:
            return .end(DotoriRoutePath.signin)

        default:
            return .none
        }
        return .none
    }
}

private extension MainTabMoordinator {
    // swiftlint: disable function_body_length
    func coordinateToMainTab() -> MoordinatorContributors {
        let homeMoordinator = homeFactory.makeMoordinator()
        let noticeMoordinator = noticeFactory.makeMoordinator()
        let selfStudyMoordinator = selfStudyFactory.makeMoordinator()
        let massageMoordinator = massageFactory.makeMoordinator()
        let musicMoordinator = musicFactory.makeMoordinator()

        Moord.use(
            homeMoordinator,
            noticeMoordinator,
            selfStudyMoordinator,
            massageMoordinator,
            musicMoordinator
        ) { root1, root2, root3, root4, root5 in
            let homeTabbarItem = UITabBarItem(
                image: .Tabbar.homeIcon,
                selectedImage: .Tabbar.selectedHomeIcon.withRenderingMode(.alwaysOriginal)
            )
            let noticeTabbarItem = UITabBarItem(
                image: .Tabbar.noticeIcon,
                selectedImage: .Tabbar.selectedNoticeIcon.withRenderingMode(.alwaysOriginal)
            )
            let selfStudyTabbarItem = UITabBarItem(
                image: .Tabbar.selfStudyIcon,
                selectedImage: .Tabbar.selectedSelfStudyIcon.withRenderingMode(.alwaysOriginal)
            )
            let massageTabbarItem = UITabBarItem(
                image: .Tabbar.massageIcon,
                selectedImage: .Tabbar.selectedMassageIcon.withRenderingMode(.alwaysOriginal)
            )
            let musicTabbarItem = UITabBarItem(
                image: .Tabbar.musicIcon,
                selectedImage: .Tabbar.selectedMusicIcon.withRenderingMode(.alwaysOriginal)
            )

            root1.tabBarItem = homeTabbarItem
            root2.tabBarItem = noticeTabbarItem
            root3.tabBarItem = selfStudyTabbarItem
            root4.tabBarItem = massageTabbarItem
            root5.tabBarItem = musicTabbarItem
            
            homeTabbarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
            noticeTabbarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
            selfStudyTabbarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
            massageTabbarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
            musicTabbarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)

            self.rootVC.setViewControllers([root1, root2, root3, root4, root5], animated: true)
        }
        return .multiple([
            .contribute(
                withNextPresentable: homeMoordinator,
                withNextRouter: DisposableRouter(singlePath: DotoriRoutePath.home)
            ),
            .contribute(
                withNextPresentable: noticeMoordinator,
                withNextRouter: DisposableRouter(singlePath: DotoriRoutePath.notice)
            ),
            .contribute(
                withNextPresentable: selfStudyMoordinator,
                withNextRouter: DisposableRouter(singlePath: DotoriRoutePath.selfStudy)
            ),
            .contribute(
                withNextPresentable: massageMoordinator,
                withNextRouter: DisposableRouter(singlePath: DotoriRoutePath.massage)
            ),
            .contribute(
                withNextPresentable: musicMoordinator,
                withNextRouter: DisposableRouter(singlePath: DotoriRoutePath.music)
            )
        ])
    }
    // swiftlint: enable function_body_length
}

private extension UITabBarItem {
    convenience init(image: UIImage?, selectedImage: UIImage?) {
        self.init(title: nil, image: image, selectedImage: selectedImage)
    }
}
