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

        default:
            return .none
        }
        return .none
    }
}

private extension MainTabMoordinator {
    func coordinateToMainTab() -> MoordinatorContributors {
        let homeMoordinator = homeFactory.makeMoordinator()
        let noticeMoordinator = noticeFactory.makeMoordinator()
        let selfStuyMoordinator = selfStudyFactory.makeMoordinator()
        let massageMoordinator = massageFactory.makeMoordinator()
        let musicMoordinator = musicFactory.makeMoordinator()

        Moord.use(
            homeMoordinator,
            noticeMoordinator,
            selfStuyMoordinator,
            massageMoordinator,
            musicMoordinator
        ) { root1, root2, root3, root4, root5 in
            
        }
        return .none
    }
}
