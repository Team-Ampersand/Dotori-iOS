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

    struct State {
        var violationList = [ViolationModel]()
    }
    enum Action {
        case fetchMyViolationList
    }
    enum Mutation {
        case updateViolationList([ViolationModel])
    }
}

extension MyViolationListStore {
    func mutate(state: State, action: Action) -> SideEffect<Mutation, Never> {
        switch action {
        case .fetchMyViolationList:
            return SideEffect<[ViolationModel], Error>
                .tryAsync { [fetchMyViolationListUseCase] in
                    try await fetchMyViolationListUseCase()
                }
                .map(Mutation.updateViolationList)
                .eraseToSideEffect()
                .catchToNever()
        }
        return .none
    }
}

extension MyViolationListStore {
    func reduce(state: State, mutate: Mutation) -> State {
        var newState = state
        switch mutate {
        case let .updateViolationList(violationList):
            newState.violationList = violationList
        }
        return newState
    }
}
