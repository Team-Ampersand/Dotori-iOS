import BaseDomainInterface
import BaseFeature
import Combine
import DateUtility
import Foundation
import Localization
import Moordinator
import MusicDomainInterface
import Store
import UIKit
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
        case cellMeatballDidTap(music: MusicModel)
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

        case let .cellMeatballDidTap(music):
            return self.cellMeatballDidTap(music: music)
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

    func cellMeatballDidTap(music: MusicModel) -> SideEffect<Mutation, Never> {
        let alertActions: [UIAlertAction] = self.cellMeatballAction(music: music)
        route.send(DotoriRoutePath.alert(style: .actionSheet, actions: alertActions))
        return .none
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

    func cellMeatballAction(music: MusicModel) -> [UIAlertAction] {
        let youtubeID = self.parseYoutubeID(url: music.url)
        var actions: [UIAlertAction] = [
            .init(title: L10n.Music.directGoTitle, style: .default, handler: { _ in
                guard let youtubeID,
                      let url = URL(string: "youtube://\(youtubeID)")
                else { return }
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url)
                } else if let webURL = URL(string: "https://youtube.com/watch?v=\(youtubeID)") {
                    UIApplication.shared.open(webURL)
                }
            })
        ]
        if currentState.currentUserRole != .member {
            actions.append(.init(title: L10n.Music.removeMusicTitle, style: .destructive, handler: { _ in
                
            }))
        }
        actions.append(.init(title: L10n.Global.cancelButtonTitle, style: .cancel))
        return actions
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

    func parseYoutubeID(url: String) -> String? {
        guard let url = URL(string: url) else { return nil }
        let queryItems = URLComponents(url: url, resolvingAgainstBaseURL: false)?.queryItems
        if let idValue = queryItems?.first(where: { $0.name == "v" })?.value {
            return idValue
        }
        return url.lastPathComponent.isEmpty ? nil : url.lastPathComponent
    }
}
