import BaseFeature
import Combine
import DesignSystem
import Foundation
import Localization
import Moordinator
import MusicDomainInterface
import Store
import UIKit

final class ProposeMusicStore: BaseStore {
    var route: PassthroughSubject<RoutePath, Never> = .init()
    var subscription: Set<AnyCancellable> = .init()
    var initialState: State
    var stateSubject: CurrentValueSubject<State, Never>
    private let proposeMusicUseCase: any ProposeMusicUseCase

    init(proposeMusicUseCase: any ProposeMusicUseCase) {
        self.initialState = .init()
        self.stateSubject = .init(initialState)
        self.proposeMusicUseCase = proposeMusicUseCase
    }

    struct State {
        var url = ""
        var isLoading = false
    }
    enum Action {
        case updateURL(String)
        case proposeButtonDidTap
        case dimmedBackgroundDidTap
        case youtubeButtonDidTap
    }
    enum Mutation {
        case updateURL(String)
        case updateIsLoading(Bool)
    }
}

extension ProposeMusicStore {
    func mutate(state: State, action: Action) -> SideEffect<Mutation, Never> {
        switch action {
        case let .updateURL(url):
            return .just(.updateURL(url))

        case .proposeButtonDidTap:
            return self.proposeButtonDidTap()

        case .dimmedBackgroundDidTap:
            route.send(DotoriRoutePath.dismiss)

        case .youtubeButtonDidTap:
            route.send(DotoriRoutePath.youtube)
        }
        return .none
    }
}

extension ProposeMusicStore {
    func reduce(state: State, mutate: Mutation) -> State {
        var newState = state
        switch mutate {
        case let .updateURL(url):
            newState.url = url
        case let .updateIsLoading(isLoading):
            newState.isLoading = isLoading
        }
        return newState
    }
}

// MARK: - Mutate
private extension ProposeMusicStore {
    func proposeButtonDidTap() -> SideEffect<Mutation, Never> {
        let proposeMusicEffect = SideEffect<Void, Error>
            .tryAsync { [url = currentState.url, proposeMusicUseCase] in
                try await proposeMusicUseCase(url: url)
            }
            .handleEvents(receiveOutput: { [route] _ in
                DotoriToast.makeToast(text: L10n.ProposeMusic.successToProposeTitle, style: .success)
                route.send(DotoriRoutePath.dismiss)
            })
            .eraseToSideEffect()
            .catchMap { error in
                DotoriToast.makeToast(text: error.localizedDescription, style: .error)
            }
            .flatMap { SideEffect<Mutation, Never>.none }
            .eraseToSideEffect()
        return self.makeLoadingSideEffect(proposeMusicEffect)
    }
}

// MARK: - Reusable
private extension ProposeMusicStore {
    func makeLoadingSideEffect(
        _ publisher: SideEffect<Mutation, Never>
    ) -> SideEffect<Mutation, Never> {
        let startLoadingPublisher = SideEffect<Mutation, Never>
            .just(Mutation.updateIsLoading(true))
        let endLoadingPublisher = SideEffect<Mutation, Never>
            .just(Mutation.updateIsLoading(false))
        return startLoadingPublisher
            .append(publisher)
            .append(endLoadingPublisher)
            .eraseToSideEffect()
    }
}
