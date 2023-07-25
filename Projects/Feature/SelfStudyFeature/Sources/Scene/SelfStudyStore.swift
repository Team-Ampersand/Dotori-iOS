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
    }
    enum Action {
        case viewDidLoad
        case selfStudyCheckButtonDidTap(id: Int, isChecked: Bool)
    }
    enum Mutation {
        case updateSelfStudyRankList([SelfStudyRankModel])
        case updateSelfStudyCheck(id: Int, isChecked: Bool)
        case updateCurrentUserRole(UserRoleType)
    }
}

extension SelfStudyStore {
    func mutate(state: State, action: Action) -> SideEffect<Mutation, Never> {
        switch action {
        case .viewDidLoad:
            return viewDidLoad()

        case let .selfStudyCheckButtonDidTap(id, isChecked):
            return selfStudyCheckButtonDidTap(memberID: id, isChecked: isChecked)
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
        }
        return newState
    }
}

extension SelfStudyStore: SelfStudyCellDelegate {
    func selfStudyCheckBoxDidTap(id: Int, isChecked: Bool) {
        self.send(.selfStudyCheckButtonDidTap(id: id, isChecked: isChecked))
    }
}

private extension SelfStudyStore {
    func viewDidLoad() -> SideEffect<Mutation, Never> {
        let selfStudyEffect = SideEffect<[SelfStudyRankModel], Error>
            .tryAsync { [fetchSelfStudyRankListUseCase] in
                try await fetchSelfStudyRankListUseCase()
            }
            .map(Mutation.updateSelfStudyRankList)
            .catchToNever()
            .eraseToSideEffect()

        let userRoleEffect = SideEffect
            .just(try? loadCurrentUserRoleUseCase())
            .replaceNil(with: .member)
            .map(Mutation.updateCurrentUserRole)
            .setFailureType(to: Never.self)
            .eraseToSideEffect()

        return .merge(
            selfStudyEffect,
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
}

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
                selfStudyCheck: isChecked
            )
        }
    }
}
