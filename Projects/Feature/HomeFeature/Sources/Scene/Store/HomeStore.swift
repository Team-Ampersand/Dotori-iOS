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
    private let fetchProfileImageUseCase: any FetchProfileImageUseCase
    private let fetchSelfStudyInfoUseCase: any FetchSelfStudyInfoUseCase
    private let fetchMassageInfoUseCase: any FetchMassageInfoUseCase
    private let fetchMealInfoUseCase: any FetchMealInfoUseCase
    private let loadCurrentUserRoleUseCase: any LoadCurrentUserRoleUseCase
    private let applySelfStudyUseCase: any ApplySelfStudyUseCase
    private let cancelSelfStudyUseCase: any CancelSelfStudyUseCase
    private let modifySelfStudyPersonnelUseCase: any ModifySelfStudyPersonnelUseCase
    private let applyMassageUseCase: any ApplyMassageUseCase
    private let cancelMassageUseCase: any CancelMassageUseCase
    private let modifyMassagePersonnelUseCase: any ModifyMassagePersonnelUseCase
    private let logoutUseCase: any LogoutUseCase
    private let withdrawalUseCase: any WithdrawalUseCase
    
    init(
        repeatableTimer: any RepeatableTimer,
        fetchProfileImageUseCase: any FetchProfileImageUseCase,
        fetchSelfStudyInfoUseCase: any FetchSelfStudyInfoUseCase,
        fetchMassageInfoUseCase: any FetchMassageInfoUseCase,
        fetchMealInfoUseCase: any FetchMealInfoUseCase,
        loadCurrentUserRoleUseCase: any LoadCurrentUserRoleUseCase,
        applySelfStudyUseCase: any ApplySelfStudyUseCase,
        cancelSelfStudyUseCase: any CancelSelfStudyUseCase,
        modifySelfStudyPersonnelUseCase: any ModifySelfStudyPersonnelUseCase,
        applyMassageUseCase: any ApplyMassageUseCase,
        cancelMassageUseCase: any CancelMassageUseCase,
        modifyMassagePersonnelUseCase: any ModifyMassagePersonnelUseCase,
        logoutUseCase: any LogoutUseCase,
        withdrawalUseCase: any WithdrawalUseCase
    ) {
        self.initialState = .init()
        self.stateSubject = .init(initialState)
        self.repeatableTimer = repeatableTimer
        self.fetchProfileImageUseCase = fetchProfileImageUseCase
        self.fetchSelfStudyInfoUseCase = fetchSelfStudyInfoUseCase
        self.fetchMassageInfoUseCase = fetchMassageInfoUseCase
        self.fetchMealInfoUseCase = fetchMealInfoUseCase
        self.loadCurrentUserRoleUseCase = loadCurrentUserRoleUseCase
        self.applySelfStudyUseCase = applySelfStudyUseCase
        self.cancelSelfStudyUseCase = cancelSelfStudyUseCase
        self.modifySelfStudyPersonnelUseCase = modifySelfStudyPersonnelUseCase
        self.applyMassageUseCase = applyMassageUseCase
        self.cancelMassageUseCase = cancelMassageUseCase
        self.modifyMassagePersonnelUseCase = modifyMassagePersonnelUseCase
        self.logoutUseCase = logoutUseCase
        self.withdrawalUseCase = withdrawalUseCase
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
        case selfStudySettingButtonDidTap
        case applyMassageButtonDidTap
        case massageSettingButtonDidTap
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
            
        case .selfStudySettingButtonDidTap:
            selfStudySettingButtonDidTap()
            
        case .applyMassageButtonDidTap:
            applyMassageButtonDidTap()
            
        case .massageSettingButtonDidTap:
            massageSettingButtonDidTap()
            
        case .refreshSelfStudyButtonDidTap:
            return fetchSelfStudyInfoSideEffect()
            
        case .refreshMassageButtonDidTap:
            return fetchMassageInfoSideEffect()
        }
        return .none
    }
    // swiftlint: enable cyclomatic_complexity
}

// MARK: - Mutate
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
        let profileImagePublisher = self.fetchProfileImageSideEffect()
        
        let selfStudyPublisher = self.fetchSelfStudyInfoSideEffect()
        
        let massagePublisher = self.fetchMassageInfoSideEffect()
        
        let mealPublisher = self.fetchMealSideEffect(date: currentState.selectedMealDate)
        
        return .merge(
            profileImagePublisher,
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
            .init(title: L10n.Home.profileEditButtonTitle, style: .default) { [route] _ in
                route.send(DotoriRoutePath.profileImage)
            },
            .init(title: L10n.Home.violationHistoryButtonTitle, style: .default) { [route] _ in
                route.send(DotoriRoutePath.myViolationList)
            },
            .init(title: L10n.Home.logoutButtonTitle, style: .default) { [route, logoutUseCase] _ in
                let confirmationDialogRoutePath = DotoriRoutePath.confirmationDialog(
                    title: L10n.Home.logoutTitle,
                    description: L10n.Home.reallyLogoutTitle
                ) {
                    logoutUseCase()
                    route.send(DotoriRoutePath.signin)
                }
                route.send(confirmationDialogRoutePath)
            },
            .init(title: L10n.Home.withdrawalTitle, style: .destructive, handler: { [route, withdrawalUseCase] _ in
                let confirmationDialogRoutePath = DotoriRoutePath.confirmationDialog(
                    title: L10n.Home.withdrawalTitle,
                    description: L10n.Home.reallyWithdrawalTitle
                ) {
                    do {
                        try await withdrawalUseCase()
                        route.send(DotoriRoutePath.signin)
                    } catch {
                        await DotoriToast.makeToast(text: error.localizedDescription, style: .error)
                    }
                }
                route.send(confirmationDialogRoutePath)
            }),
            .init(title: L10n.Global.cancelButtonTitle, style: .cancel)
        ])
        self.route.send(alertPath)
        return .none
    }
    
    func applySelfStudyButtonDidTap() {
        Task.catching {
            if self.currentState.selfStudyStatus == .applied {
                let confirmRoutePath = DotoriRoutePath.confirmationDialog(
                    title: L10n.Home.cancelSelfStudyTitle,
                    description: L10n.Home.reallyCancelSelfStudyTitle
                ) { [cancelSelfStudyUseCase = self.cancelSelfStudyUseCase] in
                    try? await cancelSelfStudyUseCase()
                    await DotoriToast.makeToast(text: L10n.Home.completeToCancelSelfStudyTitle, style: .success)
                }
                self.route.send(confirmRoutePath)
            } else {
                try await self.applySelfStudyUseCase()
                await DotoriToast.makeToast(text: L10n.Home.completeToApplySelfStudyTitle, style: .success)
            }
            self.send(.refreshSelfStudyButtonDidTap)
        } catch: { @MainActor error in
            DotoriToast.makeToast(text: error.localizedDescription, style: .error)
        }
    }
    
    func selfStudySettingButtonDidTap() {
        let inputDialogRoutePath = DotoriRoutePath.inputDialog(
            title: L10n.Home.selfStudyModifyLimitTitle,
            placeholder: "\(currentState.selfStudyInfo.1)",
            inputType: .number
        ) { [modifySelfStudyPersonnelUseCase, weak self] limit in
            do {
                guard let limitInt = Int(limit) else { return }
                try await modifySelfStudyPersonnelUseCase(limit: limitInt)
                await DotoriToast.makeToast(text: L10n.Home.completeToModifySelfStudyLimitTitle, style: .success)
                self?.send(.refreshSelfStudyButtonDidTap)
            } catch {
                await DotoriToast.makeToast(text: error.localizedDescription, style: .error)
            }
        }
        route.send(inputDialogRoutePath)
    }
    
    func applyMassageButtonDidTap() {
        Task.catching {
            if self.currentState.massageStatus == .applied {
                let confirmRoutePath = DotoriRoutePath.confirmationDialog(
                    title: L10n.Home.cancelMassageTitle,
                    description: L10n.Home.reallyCancelMassageTitle
                ) { [cancelMassageUseCase = self.cancelMassageUseCase] in
                    try? await cancelMassageUseCase()
                    await DotoriToast.makeToast(text: L10n.Home.completeToCancelMassageTitle, style: .success)
                }
                self.route.send(confirmRoutePath)
            } else {
                try await self.applyMassageUseCase()
                await DotoriToast.makeToast(text: L10n.Home.completeToApplyMassageTitle, style: .success)
            }
            self.send(.refreshMassageButtonDidTap)
        } catch: { @MainActor error in
            DotoriToast.makeToast(text: error.localizedDescription, style: .error)
        }
    }
    
    func massageSettingButtonDidTap() {
        let inputDialogRoutePath = DotoriRoutePath.inputDialog(
            title: L10n.Home.massageModifyLimitTitle,
            placeholder: "\(currentState.massageInfo.1)",
            inputType: .number
        ) { [modifyMassagePersonnelUseCase, weak self] limit in
            do {
                guard let limitInt = Int(limit) else { return }
                try await modifyMassagePersonnelUseCase(limit: limitInt)
                await DotoriToast.makeToast(text: L10n.Home.completeToModifyMassageLimitTitle, style: .success)
                self?.send(.refreshMassageButtonDidTap)
            } catch {
                await DotoriToast.makeToast(text: error.localizedDescription, style: .error)
            }
        }
        route.send(inputDialogRoutePath)
    }
}

private extension HomeStore {
    func fetchProfileImageSideEffect() -> SideEffect<Mutation, Never> {
        let profileImagePublisher = SideEffect<String, Error>
            .tryAsync {
                try await self.fetchProfileImageUseCase()
            }
            .map(Mutation.updateProfileImage)
            .eraseToSideEffect()
            .catchToNever()
        return profileImagePublisher
    }
    
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
}

// MARK: - Reusable
private extension HomeStore {
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
