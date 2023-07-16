import BaseFeature
import Combine
import Foundation
import MassageDomainInterface
import MealDomainInterface
import Moordinator
import SelfStudyDomainInterface
import Store
import TimerInterface

final class HomeStore: BaseStore {
    var route: PassthroughSubject<RoutePath, Never> = .init()
    var subscription: Set<AnyCancellable> = .init()
    var initialState: State
    var stateSubject: CurrentValueSubject<State, Never>
    private let repeatableTimer: any RepeatableTimer
    private let fetchSelfStudyInfoUseCase: any FetchSelfStudyInfoUseCase
    private let fetchMassageInfoUseCase: any FetchMassageInfoUseCase
    private let fetchMealInfoUseCase: any FetchMealInfoUseCase

    init(
        repeatableTimer: any RepeatableTimer,
        fetchSelfStudyInfoUseCase: any FetchSelfStudyInfoUseCase,
        fetchMassageInfoUseCase: any FetchMassageInfoUseCase,
        fetchMealInfoUseCase: any FetchMealInfoUseCase
    ) {
        self.initialState = .init()
        self.stateSubject = .init(initialState)
        self.repeatableTimer = repeatableTimer
        self.fetchSelfStudyInfoUseCase = fetchSelfStudyInfoUseCase
        self.fetchMassageInfoUseCase = fetchMassageInfoUseCase
        self.fetchMealInfoUseCase = fetchMealInfoUseCase
    }

    struct State {
        var currentTime: Date = .init()
        var selfStudyInfo: (Int, Int) = (0, 0)
        var massageInfo: (Int, Int) = (0, 0)
        var selectedMealDate: Date = Date()
        var selectedMealType: MealType = .breakfast
        var mealInfo: [MealInfoModel] = []
    }
    enum Action: Equatable {
        case viewDidLoad
        case myInfoButtonDidTap
    }
    enum Mutation {
        case updateCurrentTime(Date)
        case updateSelfStudyInfo((Int, Int))
        case updateMassageInfo((Int, Int))
        case updateSelectedMealDate(Date)
        case updateSelectedMealType(MealType)
        case updateMealInfo([MealInfoModel])
    }
}

extension HomeStore {
    func mutate(state: State, action: Action) -> SideEffect<Mutation, Never> {
        switch action {
        case .viewDidLoad:
            return viewDidLoad()

        case .myInfoButtonDidTap:
            return myInfoButtonDidTap()

        default:
            return .none
        }
    }
}

extension HomeStore {
    func reduce(state: State, mutate: Mutation) -> State {
        var newState = state

        switch mutate {
        case let .updateCurrentTime(date):
            newState.currentTime = date
        case let .updateSelfStudyInfo(selfStudyInfo):
            newState.selfStudyInfo = selfStudyInfo
        case let .updateMassageInfo(massageInfo):
            newState.massageInfo = massageInfo
        case let .updateSelectedMealDate(date):
            newState.selectedMealDate = date
        case let .updateSelectedMealType(type):
            newState.selectedMealType = type
        case let .updateMealInfo(mealInfo):
            newState.mealInfo = mealInfo
        }

        return newState
    }
}

private extension HomeStore {
    func viewDidLoad() -> SideEffect<Mutation, Never> {
        let timerPublisher = repeatableTimer.repeatPublisher(every: 1.0)
            .map(Mutation.updateCurrentTime)
            .eraseToSideEffect()

        let selfStudyPublisher = SideEffect<SelfStudyInfoModel, Never>
            .tryAsync {
                try await self.fetchSelfStudyInfoUseCase()
            }
            .map { Mutation.updateSelfStudyInfo(($0.count, $0.limit)) }
            .catchToNever()

        let massagePublisher = SideEffect<MassageInfoModel, Never>
            .tryAsync {
                try await self.fetchMassageInfoUseCase()
            }
            .map { Mutation.updateMassageInfo(($0.count, $0.limit)) }
            .catchToNever()

        let mealPublisher = self.fetchMealInfoUseCase(date: currentState.selectedMealDate)
            .toAnyPublisher()
            .compactMap { status in
                switch status {
                case let .loading(mealInfo):
                    return Mutation.updateMealInfo(mealInfo ?? [])

                case let .completed(mealInfo):
                    return Mutation.updateMealInfo(mealInfo)

                default:
                    return nil
                }
            }
            .eraseToSideEffect()

        return .merge(
            timerPublisher,
            selfStudyPublisher,
            massagePublisher,
            mealPublisher
        )
    }

    func myInfoButtonDidTap() -> SideEffect<Mutation, Never> {
        let alertPath = DotoriRoutePath.alert(style: .actionSheet, actions: [
            .init(title: "프로필 수정", style: .default) { _ in },
            .init(title: "규정위반 내역", style: .default) { _ in },
            .init(title: "비밀번호 변경", style: .default) { _ in },
            .init(title: "로그아웃", style: .default) { _ in },
            .init(title: "취소", style: .cancel)
        ])
        self.route.send(alertPath)
        return .none
    }
}
