import Moordinator
import MusicDomainInterface
import ProposeMusicFeature
import UserDomainInterface

struct MusicFactoryImpl: MusicFactory {
    private let fetchMusicListUseCase: any FetchMusicListUseCase
    private let removeMusicUseCase: any RemoveMusicUseCase
    private let loadCurrentUserRoleUseCase: any LoadCurrentUserRoleUseCase
    private let proposeMusicFactory: any ProposeMusicFactory

    init(
        fetchMusicListUseCase: any FetchMusicListUseCase,
        removeMusicUseCase: any RemoveMusicUseCase,
        loadCurrentUserRoleUseCase: any LoadCurrentUserRoleUseCase,
        proposeMusicFactory: any ProposeMusicFactory
    ) {
        self.fetchMusicListUseCase = fetchMusicListUseCase
        self.removeMusicUseCase = removeMusicUseCase
        self.loadCurrentUserRoleUseCase = loadCurrentUserRoleUseCase
        self.proposeMusicFactory = proposeMusicFactory
    }

    func makeMoordinator() -> Moordinator {
        let store = MusicStore(
            fetchMusicListUseCase: fetchMusicListUseCase,
            removeMusicUseCase: removeMusicUseCase,
            loadCurrentUserRoleUseCase: loadCurrentUserRoleUseCase
        )
        let viewController = MusicViewController(store: store)
        return MusicMoordinator(
            musicViewController: viewController,
            proposeMusicFactory: proposeMusicFactory
        )
    }
}
