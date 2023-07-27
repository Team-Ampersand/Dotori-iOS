import BaseFeature
import Combine
import Moordinator
import Store

final class ProposeMusicStore: BaseStore {
    var route: PassthroughSubject<RoutePath, Never> = .init()
    var subscription: Set<AnyCancellable> = .init()
    var initialState: State
    var stateSubject: CurrentValueSubject<State, Never>

    init() {
        self.initialState = .init()
        self.stateSubject = .init(initialState)
    }

    struct State {}
    enum Action {}
    enum Mutation {}
}

extension ProposeMusicStore {
    func mutate(state: State, action: Action) -> SideEffect<Mutation, Never> {
        .none
    }
}

extension ProposeMusicStore {
    func reduce(state: State, mutate: Mutation) -> State {
        var newState = state
        return newState
    }
}
