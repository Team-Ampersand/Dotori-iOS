import Moordinator
import MusicDomainInterface
import UserDomainInterface

struct MusicFactoryImpl: MusicFactory {
    private let fetchMusicListUseCase: any FetchMusicListUseCase
    private let loadCurrentUserRoleUseCase: any LoadCurrentUserRoleUseCase

    init(
        fetchMusicListUseCase: any FetchMusicListUseCase,
        loadCurrentUserRoleUseCase: any LoadCurrentUserRoleUseCase
    ) {
        self.fetchMusicListUseCase = fetchMusicListUseCase
        self.loadCurrentUserRoleUseCase = loadCurrentUserRoleUseCase
    }


    func makeMoordinator() -> Moordinator {
        let store = MusicStore(
            fetchMusicListUseCase: fetchMusicListUseCase,
            loadCurrentUserRoleUseCase: loadCurrentUserRoleUseCase
        )
        let viewController = MusicViewController(store: store)
        return MusicMoordinator(musicViewController: viewController)
    }
}
