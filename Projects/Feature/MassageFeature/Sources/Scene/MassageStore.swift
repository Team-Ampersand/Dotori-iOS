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

    struct State {
        var massageRankList: [MassageRankModel] = []
    }
    enum Action {
        case fetchMassageRankList
    }
    enum Mutation {
        case updateMassageRankList([MassageRankModel])
    }
}

extension MassageStore {
    func mutate(state: State, action: Action) -> SideEffect<Mutation, Never> {
        switch action {
        case .fetchMassageRankList:
            return fetchMassageRankList()
        }
    }
}

extension MassageStore {
    func reduce(state: State, mutate: Mutation) -> State {
        var newState = state
        switch mutate {
        case let .updateMassageRankList(rankList):
            newState.massageRankList = rankList
        }
        return newState
    }
}

private extension MassageStore {
    func fetchMassageRankList() -> SideEffect<Mutation, Never> {
        return SideEffect<[MassageRankModel], Error>
            .tryAsync { [fetchMassageRankListUseCase] in
                try await fetchMassageRankListUseCase()
            }
            .map(Mutation.updateMassageRankList)
            .eraseToSideEffect()
            .catchToNever()
    }
}
