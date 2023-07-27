import Moordinator
import MusicDomainInterface
import UserDomainInterface

struct MusicFactoryImpl: MusicFactory {
    private let fetchMusicListUseCase: any FetchMusicListUseCase
    private let removeMusicUseCase: any RemoveMusicUseCase
    private let loadCurrentUserRoleUseCase: any LoadCurrentUserRoleUseCase

    init(
        fetchMusicListUseCase: any FetchMusicListUseCase,
        removeMusicUseCase: any RemoveMusicUseCase,
        loadCurrentUserRoleUseCase: any LoadCurrentUserRoleUseCase
    ) {
        self.fetchMusicListUseCase = fetchMusicListUseCase
        self.removeMusicUseCase = removeMusicUseCase
        self.loadCurrentUserRoleUseCase = loadCurrentUserRoleUseCase
    }


    func makeMoordinator() -> Moordinator {
        let store = MusicStore(
            fetchMusicListUseCase: fetchMusicListUseCase,
            removeMusicUseCase: removeMusicUseCase,
            loadCurrentUserRoleUseCase: loadCurrentUserRoleUseCase
        )
        let viewController = MusicViewController(store: store)
        return MusicMoordinator(musicViewController: viewController)
    }
}
