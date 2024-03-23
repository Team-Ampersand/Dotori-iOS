import BaseFeature
import Combine
import Foundation
import Moordinator
import Store

final class ConfirmationDialogStore: BaseStore {
    var route: PassthroughSubject<RoutePath, Never> = .init()
    var subscription: Set<AnyCancellable> = .init()
    var initialState: State
    var stateSubject: CurrentValueSubject<State, Never>
    private let confirmAction: () async -> Void

    init(confirmAction: @escaping () async -> Void) {
        self.initialState = .init()
        self.stateSubject = .init(initialState)
        self.confirmAction = confirmAction
    }

    struct State {
        var isLoading = false
    }

    enum Action {
        case cancelButtonDidTap
        case confirmButtonDidTap
    }

    enum Mutation {
        case updateIsLoading(Bool)
    }

    func mutate(state: State, action: Action) -> SideEffect<Mutation, Never> {
        switch action {
        case .cancelButtonDidTap:
            route.send(DotoriRoutePath.dismiss())

        case .confirmButtonDidTap:
            let confirmEffect = SideEffect<Void, Never>
                .async { [confirmAction] in
                    await confirmAction()
                }
                .handleEvents(receiveOutput: { [route] in
                    route.send(DotoriRoutePath.dismiss())
                })
                .flatMap { SideEffect<Mutation, Never>.none }
                .eraseToSideEffect()
            return .merge(
                confirmEffect,
                .just(.updateIsLoading(true))
            )
        }
        return .none
    }

    func reduce(state: State, mutate: Mutation) -> State {
        var newState = state
        switch mutate {
        case let .updateIsLoading(isLoading):
            newState.isLoading = isLoading
        }
        return newState
    }
}
