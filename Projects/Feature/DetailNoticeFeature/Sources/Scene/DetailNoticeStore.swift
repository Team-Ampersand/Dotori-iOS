import BaseFeature
import Combine
import Moordinator
import NoticeDomainInterface
import Store

final class DetailNoticeStore: BaseStore {
    var route: PassthroughSubject<RoutePath, Never> = .init()
    var subscription: Set<AnyCancellable> = .init()
    var initialState: State
    var stateSubject: CurrentValueSubject<State, Never>
    private let fetchNoticeUseCase: any FetchNoticeUseCase

    init(
        fetchNoticeUseCase: any FetchNoticeUseCase
    ) {
        self.initialState = .init()
        self.stateSubject = .init(initialState)
        self.fetchNoticeUseCase = fetchNoticeUseCase
    }

    struct State {}
    enum Action {}
    enum Mutation {}
}

extension DetailNoticeStore {
    func mutate(state: State, action: Action) -> SideEffect<Mutation, Never> {
        .none
    }
}

extension DetailNoticeStore {
    func reduce(state: State, mutate: Mutation) -> State {
        var newState = state
        return newState
    }
}
