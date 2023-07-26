import BaseDomainInterface
import BaseFeature
import Combine
import DateUtility
import Foundation
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
        var isRefreshing = false
        var currentUserRole = UserRoleType.member
    }
    enum Action {
        case viewDidLoad
        case refresh
    }
    enum Mutation {
        case updateMusicList([MusicModel])
        case updateIsRefreshing(Bool)
        case updateCurrentUserRole(UserRoleType)
    }
}

extension MusicStore {
    func mutate(state: State, action: Action) -> SideEffect<Mutation, Never> {
        switch action {
        case .viewDidLoad, .refresh:
            return self.fetchMusicList()
        }
    }
}

extension MusicStore {
    func reduce(state: State, mutate: Mutation) -> State {
        var newState = state
        switch mutate {
        case let .updateMusicList(musicList):
            newState.musicList = musicList
        case let .updateIsRefreshing(isRefreshing):
            newState.isRefreshing = isRefreshing
        case let .updateCurrentUserRole(userRole):
            newState.currentUserRole = userRole
        }
        return newState
    }
}

// MARK: - Mutate
private extension MusicStore {
    func viewDidLoad() -> SideEffect<Mutation, Never> {
        let fetchMusicListEffect = self.fetchMusicList()

        let userRoleEffect = SideEffect
            .just(try? loadCurrentUserRoleUseCase())
            .replaceNil(with: .member)
            .setFailureType(to: Never.self)
            .map(Mutation.updateCurrentUserRole)
            .eraseToSideEffect()

        return .merge(
            fetchMusicListEffect,
            userRoleEffect
        )
    }

    func fetchMusicList() -> SideEffect<Mutation, Never> {
        guard !currentState.isRefreshing else { return .none }
        let musicListEffect = SideEffect<[MusicModel], Error>
            .tryAsync { [fetchMusicListUseCase] in
                try await fetchMusicListUseCase(date: Date().toStringWithCustomFormat("yyyy-MM-dd"))
            }
            .map(Mutation.updateMusicList)
            .eraseToSideEffect()
            .catchToNever()
        return self.makeRefreshingSideEffect(musicListEffect)
    }
}

// MARK: - Reusable
private extension MusicStore {
    func makeRefreshingSideEffect(
        _ publisher: SideEffect<Mutation, Never>
    ) -> SideEffect<Mutation, Never> {
        let startLoadingPublisher = SideEffect<Mutation, Never>
            .just(Mutation.updateIsRefreshing(true))
        let endLoadingPublisher = SideEffect<Mutation, Never>
            .just(Mutation.updateIsRefreshing(false))
        return startLoadingPublisher
            .append(publisher)
            .append(endLoadingPublisher)
            .eraseToSideEffect()
    }
}
