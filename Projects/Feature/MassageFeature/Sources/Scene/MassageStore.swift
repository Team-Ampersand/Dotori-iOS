import BaseDomainInterface
import BaseFeature
import Combine
import MassageDomainInterface
import Moordinator
import Store
import UserDomainInterface

final class MassageStore: BaseStore {
    var route: PassthroughSubject<RoutePath, Never> = .init()
    var subscription: Set<AnyCancellable> = .init()
    var initialState: State
    var stateSubject: CurrentValueSubject<State, Never>
    private let fetchMassageRankListUseCase: any FetchMassageRankListUseCase

    init(
        fetchMassageRankListUseCase: any FetchMassageRankListUseCase
    ) {
        self.initialState = .init()
        self.stateSubject = .init(initialState)
        self.fetchMassageRankListUseCase = fetchMassageRankListUseCase
    }

    struct State {
        var massageRankList: [MassageRankModel] = []
        var isRefreshing = false
    }

    enum Action {
        case viewDidLoad
        case fetchMassageRankList
    }

    enum Mutation {
        case updateMassageRankList([MassageRankModel])
        case updateIsRefreshing(Bool)
    }
}

extension MassageStore {
    func mutate(state: State, action: Action) -> SideEffect<Mutation, Never> {
        switch action {
        case .viewDidLoad:
            return viewDidLoad()

        case .fetchMassageRankList:
            return fetchMassageRankList()
        }
        return .none
    }
}

extension MassageStore {
    func reduce(state: State, mutate: Mutation) -> State {
        var newState = state
        switch mutate {
        case let .updateMassageRankList(rankList):
            newState.massageRankList = rankList

        case let .updateIsRefreshing(isRefreshing):
            newState.isRefreshing = isRefreshing
        }
        return newState
    }
}

// MARK: - Mutate
private extension MassageStore {
    func viewDidLoad() -> SideEffect<Mutation, Never> {
        return self.fetchMassageRankList()
    }

    func fetchMassageRankList() -> SideEffect<Mutation, Never> {
        let massageRankListEffect = SideEffect<[MassageRankModel], Error>
            .tryAsync { [fetchMassageRankListUseCase] in
                try await fetchMassageRankListUseCase()
            }
            .map(Mutation.updateMassageRankList)
            .eraseToSideEffect()
            .catchToNever()
        return self.makeRefreshingSideEffect(massageRankListEffect)
    }
}

// MARK: - Reusable
private extension MassageStore {
    func makeRefreshingSideEffect(
        _ publisher: SideEffect<Mutation, Never>
    ) -> SideEffect<Mutation, Never> {
        let startLoadingPublisher = SideEffect<Mutation, Never>
            .just(Mutation.updateIsRefreshing(true))
        let endLoadingPublisher = SideEffect<Mutation, Never>
            .just(Mutation.updateIsRefreshing(false))
        return startLoadingPublisher
            .append(publisher)
            .append(endLoadingPublisher)
            .eraseToSideEffect()
    }
}
