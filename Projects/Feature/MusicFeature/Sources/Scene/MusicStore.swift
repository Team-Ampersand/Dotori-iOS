import BaseFeature
import Combine
import Moordinator
import MusicDomainInterface
import Store
import UserDomainInterface

final class MusicStore: BaseStore {
    var route: PassthroughSubject<RoutePath, Never> = .init()
    var subscription: Set<AnyCancellable> = .init()
    var initialState: State
    var stateSubject: CurrentValueSubject<State, Never>
    private let fetchMusicListUseCase: any FetchMusicListUseCase
    private let loadCurrentUserRoleUseCase: any LoadCurrentUserRoleUseCase

    init(
        fetchMusicListUseCase: any FetchMusicListUseCase,
        loadCurrentUserRoleUseCase: any LoadCurrentUserRoleUseCase
    ) {
        self.initialState = .init()
        self.stateSubject = .init(initialState)
        self.fetchMusicListUseCase = fetchMusicListUseCase
        self.loadCurrentUserRoleUseCase = loadCurrentUserRoleUseCase
    }

    struct State {
        var musicList = [MusicModel]()
    }
    enum Action {}
    enum Mutation {
        case updateMusicList([MusicModel])
    }
}

extension MusicStore {
    func mutate(state: State, action: Action) -> SideEffect<Mutation, Never> {
        .none
    }
}

extension MusicStore {
    func reduce(state: State, mutate: Mutation) -> State {
        var newState = state
        switch mutate {
        case let .updateMusicList(musicList):
            newState.musicList = musicList
        }
        return newState
    }
}
