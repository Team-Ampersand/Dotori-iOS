import BaseDomainInterface
import BaseFeature
import Combine
import DesignSystem
import Localization
import Moordinator
import NoticeDomainInterface
import Store
import UIKit
import UserDomainInterface

final class DetailNoticeStore: BaseStore {
    var route: PassthroughSubject<RoutePath, Never> = .init()
    var subscription: Set<AnyCancellable> = .init()
    var initialState: State
    var stateSubject: CurrentValueSubject<State, Never>
    private let noticeID: Int
    private let fetchNoticeUseCase: any FetchNoticeUseCase
    private let removeNoticeUseCase: any RemoveNoticeUseCase
    private let loadCurrentUserRoleUseCase: any LoadCurrentUserRoleUseCase

    init(
        noticeID: Int,
        fetchNoticeUseCase: any FetchNoticeUseCase,
        removeNoticeUseCase: any RemoveNoticeUseCase,
        loadCurrentUserRoleUseCase: any LoadCurrentUserRoleUseCase
    ) {
        self.initialState = .init()
        self.stateSubject = .init(initialState)
        self.noticeID = noticeID
        self.fetchNoticeUseCase = fetchNoticeUseCase
        self.removeNoticeUseCase = removeNoticeUseCase
        self.loadCurrentUserRoleUseCase = loadCurrentUserRoleUseCase
    }

    struct State {
        var detailNotice: DetailNoticeModel?
        var isLoading = false
        var currentUserRole = UserRoleType.member
    }
    enum Action {
        case viewDidLoad
        case viewWillAppear
        case removeBarButtonDidTap
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

        case .removeBarButtonDidTap:
            return self.removeBarButtonDidTap()
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
            .just(try? loadCurrentUserRoleUseCase())
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

    func removeBarButtonDidTap() -> SideEffect<Mutation, Never> {
        let confirmRoutePath = DotoriRoutePath.confirmationDialog(
            title: L10n.Notice.removeNoticeDialogTitle,
            description: L10n.Notice.removeNoticeDialogDescription
        ) { [removeNoticeUseCase, noticeID, route] in
            do {
                try await removeNoticeUseCase(id: noticeID)
                route.send(DotoriRoutePath.dismiss)
                route.send(DotoriRoutePath.pop)
                await DotoriToast.makeToast(text: L10n.Notice.completeToRemoveNotice, style: .success)
            } catch {
                await DotoriToast.makeToast(text: error.localizedDescription, style: .error)
            }
        }
        route.send(confirmRoutePath)
        return .none
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
