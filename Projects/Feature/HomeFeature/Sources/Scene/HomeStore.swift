import BaseFeature
import Combine
import Store
import Moordinator

final class HomeStore: BaseStore {
    var route: PassthroughSubject<RoutePath, Never> = .init()
    var subscription: Set<AnyCancellable> = .init()
    var initialState: State
    var stateSubject: CurrentValueSubject<State, Never>

    init() {
        self.initialState = .init()
        self.stateSubject = .init(initialState)
    }

    struct State: Equatable {}
    enum Action: Equatable {}
    enum Mutation {}
}

extension HomeStore {
    func mutate(state: State, action: Action) -> SideEffect<Mutation, Never> {
        return .none
    }
}

extension HomeStore {
    func reduce(state: State, mutate: Mutation) -> State {
        var newState = state
        return newState
    }
}
