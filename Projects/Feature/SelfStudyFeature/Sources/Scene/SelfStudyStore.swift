import BaseFeature
import Combine
import Store
import Moordinator

final class SelfStudyStore: BaseStore {
    var route: PassthroughSubject<RoutePath, Never> = .init()
    var subscription: Set<AnyCancellable> = .init()
    var initialState: State
    var stateSubject: CurrentValueSubject<State, Never>

    init() {
        initialState = .init()
        stateSubject = .init(initialState)
    }

    struct State {}
    enum Action {}
    enum Mutation {}
}

extension SelfStudyStore {
    func mutate(state: State, action: Action) -> SideEffect<Mutation, Never> {
        .none
    }
}

extension SelfStudyStore {
    func reduce(state: State, mutate: Mutation) -> State {
        state
    }
}
