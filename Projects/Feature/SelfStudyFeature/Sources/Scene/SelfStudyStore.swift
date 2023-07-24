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

    struct State {
        var selfStudyRankList: [SelfStudyRankModel] = []
    }
    enum Action {
        case viewDidLoad
        case selfStudyCheckButtonDidTap(id: Int, isChecked: Bool)
    }
    enum Mutation {
        case updateSelfStudyRankList([SelfStudyRankModel])
        case updateSelfStudyCheck(id: Int, isChecked: Bool)
    }
}

extension SelfStudyStore {
    func mutate(state: State, action: Action) -> SideEffect<Mutation, Never> {
        switch action {
        case .viewDidLoad:
            return viewDidLoad()

        case let .selfStudyCheckButtonDidTap(id, isChecked):
            return .just(.updateSelfStudyCheck(id: id, isChecked: isChecked))
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
        return SideEffect<[SelfStudyRankModel], Error>
            .tryAsync { [fetchSelfStudyRankListUseCase] in
                try await fetchSelfStudyRankListUseCase()
            }
            .map { .updateSelfStudyRankList($0) }
            .catchToNever()
            .eraseToSideEffect()
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
