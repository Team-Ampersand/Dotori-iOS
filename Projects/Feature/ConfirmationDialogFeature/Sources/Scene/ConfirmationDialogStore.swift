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
    private let confirmAction: () -> Void

    init(confirmAction: @escaping () -> Void) {
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
            route.send(DotoriRoutePath.dismiss)

        case .confirmButtonDidTap:
            confirmAction()
            return .just(.updateIsLoading(true))
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
