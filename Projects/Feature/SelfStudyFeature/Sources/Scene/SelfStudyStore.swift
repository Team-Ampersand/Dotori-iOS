import BaseFeature
import Combine
import Moordinator
import SelfStudyDomainInterface
import Store

final class SelfStudyStore: BaseStore {
    var route: PassthroughSubject<RoutePath, Never> = .init()
    var subscription: Set<AnyCancellable> = .init()
    var initialState: State
    var stateSubject: CurrentValueSubject<State, Never>
    private let fetchSelfStudyRankListUseCase: any FetchSelfStudyRankListUseCase

    init(fetchSelfStudyRankListUseCase: any FetchSelfStudyRankListUseCase) {
        self.initialState = .init()
        self.stateSubject = .init(initialState)
        self.fetchSelfStudyRankListUseCase = fetchSelfStudyRankListUseCase
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
