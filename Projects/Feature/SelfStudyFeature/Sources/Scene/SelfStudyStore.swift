import BaseDomainInterface
import BaseFeature
import Combine
import Moordinator
import SelfStudyDomainInterface
import Store
import UserDomainInterface

final class SelfStudyStore: BaseStore {
    var route: PassthroughSubject<RoutePath, Never> = .init()
    var subscription: Set<AnyCancellable> = .init()
    var initialState: State
    var stateSubject: CurrentValueSubject<State, Never>
    private let fetchSelfStudyRankListUseCase: any FetchSelfStudyRankListUseCase
    private let loadCurrentUserRoleUseCase: any LoadCurrentUserRoleUseCase
    private let checkSelfStudyMemberUseCase: any CheckSelfStudyMemberUseCase

    init(
        fetchSelfStudyRankListUseCase: any FetchSelfStudyRankListUseCase,
        loadCurrentUserRoleUseCase: any LoadCurrentUserRoleUseCase,
        checkSelfStudyMemberUseCase: any CheckSelfStudyMemberUseCase
    ) {
        self.initialState = .init()
        self.stateSubject = .init(initialState)
        self.fetchSelfStudyRankListUseCase = fetchSelfStudyRankListUseCase
        self.loadCurrentUserRoleUseCase = loadCurrentUserRoleUseCase
        self.checkSelfStudyMemberUseCase = checkSelfStudyMemberUseCase
    }

    struct State {
        var selfStudyRankList: [SelfStudyRankModel] = []
        var currentUserRole = UserRoleType.member
        var isRefreshing = false
        var selfStudySearchRequestDTO: FetchSelfStudyRankSearchRequestDTO?
    }

    enum Action {
        case fetchSelfStudyRank
        case selfStudyCheckButtonDidTap(id: Int, isChecked: Bool)
        case refresh
        case filterButtonDidTap
        case updateSelfStudySearchRequestDTO(FetchSelfStudyRankSearchRequestDTO?)
    }

    enum Mutation {
        case updateSelfStudyRankList([SelfStudyRankModel])
        case updateSelfStudyCheck(id: Int, isChecked: Bool)
        case updateCurrentUserRole(UserRoleType)
        case updateIsRefreshing(Bool)
        case updateSelfStudySearchRequestDTO(FetchSelfStudyRankSearchRequestDTO?)
    }
}

extension SelfStudyStore {
    func mutate(state: State, action: Action) -> SideEffect<Mutation, Never> {
        switch action {
        case .fetchSelfStudyRank, .refresh:
            return fetchSelfStudyRank()

        case let .selfStudyCheckButtonDidTap(id, isChecked):
            return selfStudyCheckButtonDidTap(memberID: id, isChecked: isChecked)

        case .filterButtonDidTap:
            return filterButtonDidTap()

        case let .updateSelfStudySearchRequestDTO(dto):
            return .just(.updateSelfStudySearchRequestDTO(dto))
        }
        return .none
    }
}

extension SelfStudyStore {
    func reduce(state: State, mutate: Mutation) -> State {
        var newState = state
        switch mutate {
        case let .updateSelfStudyRankList(rankList):
            newState.selfStudyRankList = rankList
        case let .updateSelfStudyCheck(id, isChecked):
            newState.selfStudyRankList = self.updateSelfStudyCheck(id: id, isChecked: isChecked)
        case let .updateCurrentUserRole(userRole):
            newState.currentUserRole = userRole
        case let .updateIsRefreshing(isRefreshing):
            newState.isRefreshing = isRefreshing
        case let .updateSelfStudySearchRequestDTO(dto):
            newState.selfStudySearchRequestDTO = dto
        }
        return newState
    }
}

// MARK: - Mutate
private extension SelfStudyStore {
    func fetchSelfStudyRank() -> SideEffect<Mutation, Never> {
        let selfStudyEffect = SideEffect<[SelfStudyRankModel], Error>
            .tryAsync { [fetchSelfStudyRankListUseCase, request = currentState.selfStudySearchRequestDTO] in
                try await fetchSelfStudyRankListUseCase(req: request)
            }
            .map(Mutation.updateSelfStudyRankList)
            .eraseToSideEffect()
            .catchToNever()

        let userRoleEffect = SideEffect
            .just(try? loadCurrentUserRoleUseCase())
            .replaceNil(with: .member)
            .map(Mutation.updateCurrentUserRole)
            .setFailureType(to: Never.self)
            .eraseToSideEffect()

        return .merge(
            self.makeRefreshingSideEffect(selfStudyEffect),
            userRoleEffect
        )
    }

    func selfStudyCheckButtonDidTap(memberID: Int, isChecked: Bool) -> SideEffect<Mutation, Never> {
        Task {
            try await checkSelfStudyMemberUseCase(memberID: memberID, isChecked: isChecked)
        }

        return SideEffect<Mutation, Never>
            .just(.updateSelfStudyCheck(id: memberID, isChecked: isChecked))
    }

    func filterButtonDidTap() -> SideEffect<Mutation, Never> {
        let filterRoutePath = DotoriRoutePath.filterSelfStudy { [weak self] name, grade, `class`, gender in
            // 모든 필드가 nil이라면 dto를 nil로
            guard name != nil || grade != nil || `class` != nil || gender != nil else {
                self?.send(.updateSelfStudySearchRequestDTO(nil))
                return
            }
            let request = FetchSelfStudyRankSearchRequestDTO(
                name: name,
                gender: GenderType(rawValue: gender ?? ""),
                grade: grade,
                classNum: `class`
            )
            self?.send(.updateSelfStudySearchRequestDTO(request))
            self?.send(.fetchSelfStudyRank)
        }
        route.send(filterRoutePath)
        return .none
    }
}

// MARK: - Reduce
private extension SelfStudyStore {
    func updateSelfStudyCheck(id: Int, isChecked: Bool) -> [SelfStudyRankModel] {
        currentState.selfStudyRankList.map {
            guard $0.id == id else { return $0 }
            return SelfStudyRankModel(
                id: id,
                rank: $0.rank,
                stuNum: $0.stuNum,
                memberName: $0.memberName,
                gender: $0.gender,
                selfStudyCheck: isChecked,
                profileImage: $0.profileImage
            )
        }
    }
}

// MARK: - Reusable
private extension SelfStudyStore {
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
