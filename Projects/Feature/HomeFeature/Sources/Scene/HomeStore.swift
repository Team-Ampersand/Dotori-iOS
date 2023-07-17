import BaseFeature
import Combine
import Foundation
import Localization
import MassageDomainInterface
import MealDomainInterface
import Moordinator
import SelfStudyDomainInterface
import Store
import TimerInterface
import UserDomainInterface

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
    private let loadCurrentUserRoleUseCase: any LoadCurrentUserRoleUseCase

    init(
        repeatableTimer: any RepeatableTimer,
        fetchSelfStudyInfoUseCase: any FetchSelfStudyInfoUseCase,
        fetchMassageInfoUseCase: any FetchMassageInfoUseCase,
        fetchMealInfoUseCase: any FetchMealInfoUseCase,
        loadCurrentUserRoleUseCase: any LoadCurrentUserRoleUseCase
    ) {
        self.initialState = .init()
        self.stateSubject = .init(initialState)
        self.repeatableTimer = repeatableTimer
        self.fetchSelfStudyInfoUseCase = fetchSelfStudyInfoUseCase
        self.fetchMassageInfoUseCase = fetchMassageInfoUseCase
        self.fetchMealInfoUseCase = fetchMealInfoUseCase
        self.loadCurrentUserRoleUseCase = loadCurrentUserRoleUseCase
    }

    struct State {
        var currentTime: Date = .init()
        var currentUserRole: UserRoleType = .member
        var selfStudyInfo: (Int, Int) = (0, 0)
        var massageInfo: (Int, Int) = (0, 0)
        var selectedMealDate: Date = Date()
        var selectedMealType: MealType = .breakfast
        var mealInfo: [MealInfoModel] = []
        var loadingState: Set<HomeLoadingState> = []
        var selfStudyStatus: SelfStudyStatusType = .cant
        var massageStatus: MassageStatusType = .cant
        var selfStudyButtonTitle: String = L10n.Home.cantApplyButtonTitle
        var massageButtonTitle: String = L10n.Home.cantApplyButtonTitle
        var selfStudyButtonIsEnabled: Bool = false
        var massageButtonIsEnabled: Bool = false
    }
    enum Action: Equatable {
        case viewDidLoad
        case myInfoButtonDidTap
        case prevDateButtonDidTap
        case nextDateButtonDidTap
        case mealTypeDidChanged(MealType)
        case selfStudyDetailButtonDidTap
        case massageDetailButtonDidTap
    }
    enum Mutation {
        case updateCurrentTime(Date)
        case updateCurrentUserRole(UserRoleType)
        case updateSelfStudyInfo((Int, Int))
        case updateMassageInfo((Int, Int))
        case updateSelectedMealDate(Date)
        case updateSelectedMealType(MealType)
        case updateMealInfo([MealInfoModel])
        case insertLoadingState(HomeLoadingState)
        case removeLoadingState(HomeLoadingState)
        case updateSelfStudyStatus(SelfStudyStatusType)
        case updateMassageStatus(MassageStatusType)
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

        case .selfStudyDetailButtonDidTap:
            route.send(DotoriRoutePath.selfStudy)

        case .massageDetailButtonDidTap:
            route.send(DotoriRoutePath.massage)
        }
        return .none
    }
}

extension HomeStore {
    func reduce(state: State, mutate: Mutation) -> State {
        var newState = state

        switch mutate {
        case let .updateCurrentTime(date):
            newState.currentTime = date
        case let .updateCurrentUserRole(userRole):
            newState.currentUserRole = userRole
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
        case let .updateSelfStudyStatus(status):
            newState.selfStudyStatus = status
            let userRole = currentState.currentUserRole
            newState.selfStudyButtonTitle = status.buttonDisplay(userRole: userRole)
            newState.selfStudyButtonIsEnabled = status.buttonIsEnabled(userRole: userRole)
        case let .updateMassageStatus(status):
            newState.massageStatus = status
            let userRole = currentState.currentUserRole
            newState.massageButtonTitle = status.buttonDisplay(userRole: userRole)
            newState.massageButtonIsEnabled = status.buttonIsEnabled(userRole: userRole)
        }

        return newState
    }
}

private extension HomeStore {
    func viewDidLoad() -> SideEffect<Mutation, Never> {
        let timerPublisher = repeatableTimer.repeatPublisher(every: 1.0)
            .map(Mutation.updateCurrentTime)
            .eraseToSideEffect()

        let userRolePublisher = SideEffect
            .just(try? loadCurrentUserRoleUseCase())
            .replaceNil(with: .member)
            .setFailureType(to: Never.self)
            .map(Mutation.updateCurrentUserRole)
            .eraseToSideEffect()

        let selfStudyPublisher = self.fetchSelfStudyInfoPublisher()

        let massagePublisher = self.fetchMassageInfoPublisher()

        let mealPublisher = self.fetchMealPublisher(date: currentState.selectedMealDate)

        return .merge(
            timerPublisher,
            userRolePublisher,
            selfStudyPublisher,
            massagePublisher,
            mealPublisher
        )
        .subscribe(on: DispatchQueue.global())
        .eraseToSideEffect()
    }

    func myInfoButtonDidTap() -> SideEffect<Mutation, Never> {
        let alertPath = DotoriRoutePath.alert(style: .actionSheet, actions: [
            .init(title: L10n.Home.profileEditButtonTitle, style: .default) { _ in },
            .init(title: L10n.Home.violationHistoryButtonTitle, style: .default) { _ in },
            .init(title: L10n.Home.changePasswordButtonTitle, style: .default) { _ in },
            .init(title: L10n.Home.logoutButtonTitle, style: .default) { _ in },
            .init(title: L10n.Global.cancelButtonTitle, style: .cancel)
        ])
        self.route.send(alertPath)
        return .none
    }

    func fetchSelfStudyInfoPublisher() -> SideEffect<Mutation, Never> {
        let selfStudyPublisher = SideEffect<SelfStudyInfoModel, Never>
            .tryAsync {
                try await self.fetchSelfStudyInfoUseCase()
            }
            .flatMap {
                SideEffect.merge(
                    .just(Mutation.updateSelfStudyInfo(($0.count, $0.limit))),
                    .just(Mutation.updateSelfStudyStatus($0.selfStudyStatus))
                )
                .setFailureType(to: Never.self)
            }
            .eraseToSideEffect()
            .catchToNever()
        return makeLoadingSideEffect(selfStudyPublisher, loadingState: .selfStudy)
    }

    func fetchMassageInfoPublisher() -> SideEffect<Mutation, Never> {
        let massagePublisher = SideEffect<MassageInfoModel, Never>
            .tryAsync {
                try await self.fetchMassageInfoUseCase()
            }
            .flatMap {
                SideEffect.merge(
                    .just(Mutation.updateMassageInfo(($0.count, $0.limit))),
                    .just(Mutation.updateMassageStatus($0.massageStatus))
                )
                .setFailureType(to: Never.self)
            }
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

extension SelfStudyStatusType {
    func buttonDisplay(userRole: UserRoleType) -> String {
        guard userRole == .member else {
            return L10n.Home.modifyLimitButtonTitle
        }
        switch self {
        case .can: return L10n.Home.canSelfStudyButtonTitle
        case .applied: return L10n.Home.appliedSelfStudyButtonTitle
        case .cant: return L10n.Home.cantApplyButtonTitle
        case .impossible: return L10n.Home.impossibleSelfStudyButtonTitle
        }
    }

    func buttonIsEnabled(userRole: UserRoleType) -> Bool {
        guard userRole == .member else {
            return true
        }
        switch self {
        case .can, .applied: return true
        case .cant, .impossible: return false
        }
    }
}

extension MassageStatusType {
    func buttonDisplay(userRole: UserRoleType) -> String {
        guard userRole == .member else {
            return L10n.Home.modifyLimitButtonTitle
        }
        switch self {
        case .can: return L10n.Home.canMassageButtonTitle
        case .cant: return L10n.Home.cantApplyButtonTitle
        case .applied: return L10n.Home.appliedMassageButtonTitle
        }
    }

    func buttonIsEnabled(userRole: UserRoleType) -> Bool {
        guard userRole == .member else {
            return true
        }
        switch self {
        case .can, .applied: return true
        case .cant: return false
        }
    }
}
