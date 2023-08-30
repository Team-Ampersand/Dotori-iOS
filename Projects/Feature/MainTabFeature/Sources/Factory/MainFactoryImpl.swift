import HomeFeatureInterface
import MainTabFeatureInterface
import MassageFeatureInterface
import Moordinator
import MusicFeatureInterface
import NoticeFeatureInterface
import SelfStudyFeatureInterface

struct MainFactoryImpl: MainFactory {
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

    func makeMoordinator() -> Moordinator {
        MainTabMoordinator(
            homeFactory: homeFactory,
            noticeFactory: noticeFactory,
            selfStudyFactory: selfStudyFactory,
            massageFactory: massageFactory,
            musicFactory: musicFactory
        )
    }
}
