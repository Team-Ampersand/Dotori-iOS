import BaseDomainInterface
import BaseFeature
import Combine
import ConcurrencyUtil
import DesignSystem
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
    private let applySelfStudyUseCase: any ApplySelfStudyUseCase
    private let cancelSelfStudyUseCase: any CancelSelfStudyUseCase
    private let applyMassageUseCase: any ApplyMassageUseCase
    private let cancelMassageUseCase: any CancelMassageUseCase
    private let logoutUseCase: any LogoutUseCase

    init(
        repeatableTimer: any RepeatableTimer,
        fetchSelfStudyInfoUseCase: any FetchSelfStudyInfoUseCase,
        fetchMassageInfoUseCase: any FetchMassageInfoUseCase,
        fetchMealInfoUseCase: any FetchMealInfoUseCase,
        loadCurrentUserRoleUseCase: any LoadCurrentUserRoleUseCase,
        applySelfStudyUseCase: any ApplySelfStudyUseCase,
        cancelSelfStudyUseCase: any CancelSelfStudyUseCase,
        applyMassageUseCase: any ApplyMassageUseCase,
        cancelMassageUseCase: any CancelMassageUseCase,
        logoutUseCase: any LogoutUseCase
    ) {
        self.initialState = .init()
        self.stateSubject = .init(initialState)
        self.repeatableTimer = repeatableTimer
        self.fetchSelfStudyInfoUseCase = fetchSelfStudyInfoUseCase
        self.fetchMassageInfoUseCase = fetchMassageInfoUseCase
        self.fetchMealInfoUseCase = fetchMealInfoUseCase
        self.loadCurrentUserRoleUseCase = loadCurrentUserRoleUseCase
        self.applySelfStudyUseCase = applySelfStudyUseCase
        self.cancelSelfStudyUseCase = cancelSelfStudyUseCase
        self.applyMassageUseCase = applyMassageUseCase
        self.cancelMassageUseCase = cancelMassageUseCase
        self.logoutUseCase = logoutUseCase
    }

    enum Action: Equatable {
        case viewDidLoad
        case myInfoButtonDidTap
        case prevDateButtonDidTap
        case nextDateButtonDidTap
        case mealTypeDidChanged(MealType)
        case selfStudyDetailButtonDidTap
        case massageDetailButtonDidTap
        case applySelfStudyButtonDidTap
        case applyMassageButtonDidTap
        case refreshSelfStudyButtonDidTap
        case refreshMassageButtonDidTap
    }
}

extension HomeStore {
    // swiftlint: disable cyclomatic_complexity
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
                self.fetchMealSideEffect(date: prevDate)
            )

        case .nextDateButtonDidTap:
            let nextDate = currentState.selectedMealDate.addingTimeInterval(86400)
            return .merge(
                .just(.updateSelectedMealDate(nextDate)),
                self.fetchMealSideEffect(date: nextDate)
            )

        case let .mealTypeDidChanged(type):
            return .just(.updateSelectedMealType(type))

        case .selfStudyDetailButtonDidTap:
            route.send(DotoriRoutePath.selfStudy)

        case .massageDetailButtonDidTap:
            route.send(DotoriRoutePath.massage)

        case .applySelfStudyButtonDidTap:
            applySelfStudyButtonDidTap()

        case .applyMassageButtonDidTap:
            applyMassageButtonDidTap()

        case .refreshSelfStudyButtonDidTap:
            return fetchSelfStudyInfoSideEffect()

        case .refreshMassageButtonDidTap:
            return fetchMassageInfoSideEffect()
        }
        return .none
    }
    // swiftlint: enable cyclomatic_complexity
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

        let selfStudyPublisher = self.fetchSelfStudyInfoSideEffect()

        let massagePublisher = self.fetchMassageInfoSideEffect()

        let mealPublisher = self.fetchMealSideEffect(date: currentState.selectedMealDate)

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
            .init(title: L10n.Home.violationHistoryButtonTitle, style: .default) { [route] _ in
                route.send(DotoriRoutePath.myViolationList)
            },
            .init(title: L10n.Home.logoutButtonTitle, style: .default) { [route, logoutUseCase] _ in
                let confirmationDialogRoutePath = DotoriRoutePath.confirmationDialog(
                    title: L10n.Home.logoutTitle,
                    message: L10n.Home.reallyLogoutTitle
                ) {
                    logoutUseCase()
                    route.send(DotoriRoutePath.signin)
                }
                route.send(confirmationDialogRoutePath)
            },
            .init(title: L10n.Global.cancelButtonTitle, style: .cancel)
        ])
        self.route.send(alertPath)
        return .none
    }

    func applySelfStudyButtonDidTap() {
//        guard currentState.currentUserRole == .member else {
//            return
//        }
        #warning("자습 인원 수정 로직 추가")
        Task.catching {
            if self.currentState.selfStudyStatus == .applied {
                let confirmRoutePath = DotoriRoutePath.confirmationDialog(
                    title: "자습 신청 취소",
                    message: "정말 자습 신청을 취소하시겠습니까?"
                ) { [cancelSelfStudyUseCase = self.cancelSelfStudyUseCase] in
                    try? await cancelSelfStudyUseCase()
                    await DotoriToast.makeToast(text: "자습을 취소하였습니다.", style: .success)
                }
                self.route.send(confirmRoutePath)
            } else {
                try await self.applySelfStudyUseCase()
                await DotoriToast.makeToast(text: "자습을 신청하였습니다.", style: .success)
            }
            self.send(.refreshSelfStudyButtonDidTap)
        } catch: { @MainActor error in
            DotoriToast.makeToast(text: error.localizedDescription, style: .error)
        }
    }

    func applyMassageButtonDidTap() {
//        guard currentState.currentUserRole == .member else {
//            return
//        }
        #warning("안마 인원 수정 로직 추가")
        Task.catching {
            if self.currentState.massageStatus == .applied {
                let confirmRoutePath = DotoriRoutePath.confirmationDialog(
                    title: "안마의자 신청 취소",
                    message: "정말 안마의자 신청을 취소하시겠습니까?"
                ) { [cancelMassageUseCase = self.cancelMassageUseCase] in
                    try? await cancelMassageUseCase()
                    await DotoriToast.makeToast(text: "안마의자를 취소하였습니다.", style: .success)
                }
                self.route.send(confirmRoutePath)
            } else {
                try await self.applyMassageUseCase()
                await DotoriToast.makeToast(text: "안마의자를 신청하였습니다.", style: .success)
            }
            self.send(.refreshMassageButtonDidTap)
        } catch: { @MainActor error in
            DotoriToast.makeToast(text: error.localizedDescription, style: .error)
        }
    }
}

private extension HomeStore {
    func fetchSelfStudyInfoSideEffect() -> SideEffect<Mutation, Never> {
        let selfStudyPublisher = SideEffect<SelfStudyInfoModel, Never>
            .tryAsync {
                try await self.fetchSelfStudyInfoUseCase()
            }
            .flatMap {
                SideEffect.merge(
                    .just(Mutation.updateSelfStudyInfo(($0.count, $0.limit))),
                    .just(Mutation.updateSelfStudyStatus($0.selfStudyStatus)),
                    .just(Mutation.updateSelfStudyRefreshDate(Date()))
                )
                .setFailureType(to: Never.self)
            }
            .eraseToSideEffect()
            .catchToNever()
        return makeLoadingSideEffect(selfStudyPublisher, loadingState: .selfStudy)
    }

    func fetchMassageInfoSideEffect() -> SideEffect<Mutation, Never> {
        let massagePublisher = SideEffect<MassageInfoModel, Never>
            .tryAsync {
                try await self.fetchMassageInfoUseCase()
            }
            .flatMap {
                SideEffect.merge(
                    .just(Mutation.updateMassageInfo(($0.count, $0.limit))),
                    .just(Mutation.updateMassageStatus($0.massageStatus)),
                    .just(Mutation.updateMassageRefreshDate(Date()))
                )
                .setFailureType(to: Never.self)
            }
            .eraseToSideEffect()
            .catchToNever()
        return makeLoadingSideEffect(massagePublisher, loadingState: .massage)
    }

    func fetchMealSideEffect(date: Date) -> SideEffect<Mutation, Never> {
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
