import BaseFeature
import Combine
import Foundation
import MassageDomainInterface
import MealDomainInterface
import Moordinator
import SelfStudyDomainInterface
import Store
import TimerInterface

enum HomeLoadingState {
    case selfStudy
    case massage
}

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
        var loadingState: Set<HomeLoadingState> = []
    }
    enum Action: Equatable {
        case viewDidLoad
        case myInfoButtonDidTap
        case prevDateButtonDidTap
        case nextDateButtonDidTap
        case mealTypeDidChanged(MealType)
    }
    enum Mutation {
        case updateCurrentTime(Date)
        case updateSelfStudyInfo((Int, Int))
        case updateMassageInfo((Int, Int))
        case updateSelectedMealDate(Date)
        case updateSelectedMealType(MealType)
        case updateMealInfo([MealInfoModel])
        case insertLoadingState(HomeLoadingState)
        case removeLoadingState(HomeLoadingState)
    }
}

extension HomeStore {
    func mutate(state: State, action: Action) -> SideEffect<Mutation, Never> {
        switch action {
        case .viewDidLoad:
            return viewDidLoad()

        case .myInfoButtonDidTap:
            return myInfoButtonDidTap()

        case .prevDateButtonDidTap:
            let prevDate = currentState.selectedMealDate.addingTimeInterval(-86400)
            return .merge(
                .just(.updateSelectedMealDate(prevDate)),
                self.fetchMealPublisher(date: prevDate)
            )

        case .nextDateButtonDidTap:
            let nextDate = currentState.selectedMealDate.addingTimeInterval(86400)
            return .merge(
                .just(.updateSelectedMealDate(nextDate)),
                self.fetchMealPublisher(date: nextDate)
            )

        case let .mealTypeDidChanged(type):
            return .just(.updateSelectedMealType(type))

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
        case let .insertLoadingState(loadingState):
            newState.loadingState.insert(loadingState)
        case let .removeLoadingState(loadingState):
            newState.loadingState.remove(loadingState)
        }

        return newState
    }
}

private extension HomeStore {
    func viewDidLoad() -> SideEffect<Mutation, Never> {
        let timerPublisher = repeatableTimer.repeatPublisher(every: 1.0)
            .map(Mutation.updateCurrentTime)
            .eraseToSideEffect()

        let selfStudyPublisher = self.fetchSelfStudyPublisher()

        let massagePublisher = self.fetchMassagePublisher()

        let mealPublisher = self.fetchMealPublisher(date: currentState.selectedMealDate)

        return .merge(
            timerPublisher,
            selfStudyPublisher,
            massagePublisher,
            mealPublisher
        )
        .subscribe(on: DispatchQueue.global())
        .eraseToSideEffect()
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

    func fetchSelfStudyPublisher() -> SideEffect<Mutation, Never> {
        let selfStudyPublisher = SideEffect<SelfStudyInfoModel, Never>
            .tryAsync {
                try await self.fetchSelfStudyInfoUseCase()
            }
            .map { Mutation.updateSelfStudyInfo(($0.count, $0.limit)) }
            .eraseToSideEffect()
            .catchToNever()
        return makeLoadingSideEffect(selfStudyPublisher, loadingState: .selfStudy)
    }

    func fetchMassagePublisher() -> SideEffect<Mutation, Never> {
        let massagePublisher = SideEffect<MassageInfoModel, Never>
            .tryAsync {
                try await self.fetchMassageInfoUseCase()
            }
            .map { Mutation.updateMassageInfo(($0.count, $0.limit)) }
            .eraseToSideEffect()
            .catchToNever()
        return makeLoadingSideEffect(massagePublisher, loadingState: .massage)
    }

    func fetchMealPublisher(date: Date) -> SideEffect<Mutation, Never> {
        return self.fetchMealInfoUseCase(date: date)
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
    }

    func makeLoadingSideEffect(
        _ publisher: SideEffect<Mutation, Never>,
        loadingState: HomeLoadingState
    ) -> SideEffect<Mutation, Never> {
        let startLoadingPublisher = SideEffect<Mutation, Never>
            .just(Mutation.insertLoadingState(loadingState))
        let endLoadingPublisher = SideEffect<Mutation, Never>
            .just(Mutation.removeLoadingState(loadingState))
        return startLoadingPublisher
            .append(publisher)
            .append(endLoadingPublisher)
            .eraseToSideEffect()
    }
}
