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
    private let noticeID: Int
    private let fetchNoticeUseCase: any FetchNoticeUseCase

    init(
        noticeID: Int,
        fetchNoticeUseCase: any FetchNoticeUseCase
    ) {
        self.initialState = .init()
        self.stateSubject = .init(initialState)
        self.noticeID = noticeID
        self.fetchNoticeUseCase = fetchNoticeUseCase
    }

    struct State {
        var detailNotice: DetailNoticeModel?
        var isLoading = false
    }
    enum Action {
        case viewWillAppear
    }
    enum Mutation {
        case updateDetailNotice(DetailNoticeModel)
        case updateIsLoading(Bool)
    }
}

extension DetailNoticeStore {
    func mutate(state: State, action: Action) -> SideEffect<Mutation, Never> {
        switch action {
        case .viewWillAppear:
            return self.viewWillAppear()
        }
        return .none
    }
}

extension DetailNoticeStore {
    func reduce(state: State, mutate: Mutation) -> State {
        var newState = state
        switch mutate {
        case let .updateDetailNotice(detailNotice):
            newState.detailNotice = detailNotice

        case let .updateIsLoading(isLoading):
            newState.isLoading = isLoading
        }
        return newState
    }
}

// MARK: - Mutate
private extension DetailNoticeStore {
    func viewWillAppear() -> SideEffect<Mutation, Never> {
        let detailNoticeEffect = SideEffect<DetailNoticeModel, Error>
            .tryAsync { [noticeID, fetchNoticeUseCase] in
                try await fetchNoticeUseCase(id: noticeID)
            }
            .catchToNever()
            .map(Mutation.updateDetailNotice)
        return self.makeLoadingSideEffect(detailNoticeEffect)
    }
}

// MARK: - Reusable
private extension DetailNoticeStore {
    func makeLoadingSideEffect(
        _ publisher: SideEffect<Mutation, Never>
    ) -> SideEffect<Mutation, Never> {
        let startLoadingPublisher = SideEffect<Mutation, Never>
            .just(Mutation.updateIsLoading(true))
        let endLoadingPublisher = SideEffect<Mutation, Never>
            .just(Mutation.updateIsLoading(false))
        return startLoadingPublisher
            .append(publisher)
            .append(endLoadingPublisher)
            .eraseToSideEffect()
    }
}
