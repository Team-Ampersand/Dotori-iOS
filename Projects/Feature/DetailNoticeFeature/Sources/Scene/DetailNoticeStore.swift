import BaseDomainInterface
import BaseFeature
import Combine
import Moordinator
import NoticeDomainInterface
import Store
import UserDomainInterface

final class DetailNoticeStore: BaseStore {
    var route: PassthroughSubject<RoutePath, Never> = .init()
    var subscription: Set<AnyCancellable> = .init()
    var initialState: State
    var stateSubject: CurrentValueSubject<State, Never>
    private let noticeID: Int
    private let fetchNoticeUseCase: any FetchNoticeUseCase
    private let loadCurrentUserRole: any LoadCurrentUserRoleUseCase

    init(
        noticeID: Int,
        fetchNoticeUseCase: any FetchNoticeUseCase,
        loadCurrentUserRole: any LoadCurrentUserRoleUseCase
    ) {
        self.initialState = .init()
        self.stateSubject = .init(initialState)
        self.noticeID = noticeID
        self.fetchNoticeUseCase = fetchNoticeUseCase
        self.loadCurrentUserRole = loadCurrentUserRole
    }

    struct State {
        var detailNotice: DetailNoticeModel?
        var isLoading = false
        var currentUserRole = UserRoleType.member
    }
    enum Action {
        case viewDidLoad
        case viewWillAppear
    }
    enum Mutation {
        case updateDetailNotice(DetailNoticeModel)
        case updateIsLoading(Bool)
        case updateCurrentUserRole(UserRoleType)
    }
}

extension DetailNoticeStore {
    func mutate(state: State, action: Action) -> SideEffect<Mutation, Never> {
        switch action {
        case .viewDidLoad:
            return self.viewDidLoad()

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

        case let .updateCurrentUserRole(userRole):
            newState.currentUserRole = userRole
        }
        return newState
    }
}

// MARK: - Mutate
private extension DetailNoticeStore {
    func viewDidLoad() -> SideEffect<Mutation, Never> {
        return SideEffect
            .just(try? loadCurrentUserRole())
            .replaceNil(with: .member)
            .setFailureType(to: Never.self)
            .map(Mutation.updateCurrentUserRole)
            .eraseToSideEffect()
    }

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
