import BaseFeature
import Combine
import Moordinator
import Store

final class NoticeStore: BaseStore {
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

extension NoticeStore {
    func mutate(state: State, action: Action) -> SideEffect<Mutation, Never> {
        return .none
    }
}

extension NoticeStore {
    func reduce(state: State, mutate: Mutation) -> State {
        var newState = state
        return newState
    }
}
