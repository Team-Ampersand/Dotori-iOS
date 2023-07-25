import BaseFeature
import Combine
import Store
import Moordinator
import ViolationDomainInterface

final class MyViolationListStore: BaseStore {
    var route: PassthroughSubject<RoutePath, Never> = .init()
    var subscription: Set<AnyCancellable> = .init()
    var initialState: State
    var stateSubject: CurrentValueSubject<State, Never>
    private let fetchMyViolationListUseCase: any FetchMyViolationListUseCase

    init(fetchMyViolationListUseCase: any FetchMyViolationListUseCase) {
        self.initialState = .init()
        self.stateSubject = .init(initialState)
        self.fetchMyViolationListUseCase = fetchMyViolationListUseCase
    }

    struct State {}
    enum Action {}
    enum Mutation {}
}

extension MyViolationListStore {
    func mutate(state: State, action: Action) -> SideEffect<Mutation, Never> {
        .none
    }
}

extension MyViolationListStore {
    func reduce(state: State, mutate: Mutation) -> State {
        state
    }
}
