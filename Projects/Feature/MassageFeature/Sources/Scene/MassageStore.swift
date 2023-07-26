import BaseFeature
import Combine
import Moordinator
import Store
import MassageDomainInterface

final class MassageStore: BaseStore {
    var route: PassthroughSubject<RoutePath, Never> = .init()
    var subscription: Set<AnyCancellable> = .init()
    var initialState: State
    var stateSubject: CurrentValueSubject<State, Never>
    private let fetchMassageRankListUseCase: any FetchMassageRankListUseCase

    init(fetchMassageRankListUseCase: any FetchMassageRankListUseCase) {
        self.initialState = .init()
        self.stateSubject = .init(initialState)
        self.fetchMassageRankListUseCase = fetchMassageRankListUseCase
    }

    struct State {}
    enum Action {}
    enum Mutation {}
}

extension MassageStore {
    func mutate(state: State, action: Action) -> SideEffect<Mutation, Never> {
        .none
    }
}

extension MassageStore {
    func reduce(state: State, mutate: Mutation) -> State {
        var newState = state
        return newState
    }
}
