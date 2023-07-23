import BaseDomainInterface
import BaseFeature
import Combine
import DateUtility
import Foundation
import Localization
import Moordinator
import NoticeDomainInterface
import Store
import UserDomainInterface

typealias SectiondNoticeTuple = (section: String, noticeList: [NoticeModel])

final class NoticeStore: BaseStore {
    var route: PassthroughSubject<RoutePath, Never> = .init()
    var subscription: Set<AnyCancellable> = .init()
    var initialState: State
    var stateSubject: CurrentValueSubject<State, Never>
    private let fetchNoticeListUseCase: any FetchNoticeListUseCase
    private let loadCurrentUserRoleUseCase: any LoadCurrentUserRoleUseCase

    init(
        fetchNoticeListUseCase: any FetchNoticeListUseCase,
        loadCurrentUserRoleUseCase: any LoadCurrentUserRoleUseCase
    ) {
        initialState = .init()
        stateSubject = .init(initialState)
        self.fetchNoticeListUseCase = fetchNoticeListUseCase
        self.loadCurrentUserRoleUseCase = loadCurrentUserRoleUseCase
    }

    struct State {
        var noticeList: [NoticeModel] = []
        var noticeSectionList: [SectiondNoticeTuple] = []
        var currentUserRole: UserRoleType = .member
        var isEditingMode = false
        var selectedNotice: Set<Int> = []
    }
    enum Action {
        case viewDidLoad
        case viewWillAppear
        case editButtonDidTap
        case noticeDidTap(Int)
    }
    enum Mutation {
        case updateNoticeList([NoticeModel])
        case updateCurrentUserRole(UserRoleType)
        case toggleIsEditing
        case insertSelectedNotice(Int)
        case removeSelectedNotice(Int)
        case removeAllSelectedNotice
    }
}

extension NoticeStore {
    func mutate(state: State, action: Action) -> SideEffect<Mutation, Never> {
        switch action {
        case .viewDidLoad:
            return viewDidLoad()

        case .viewWillAppear:
            return viewWillAppear()

        case .editButtonDidTap:
            return .merge(
                .just(.toggleIsEditing),
                .just(.removeAllSelectedNotice)
            )

        case let .noticeDidTap(noticeID):
            return noticeDidTap(noticeID: noticeID)
        }
        return .none
    }
}

extension NoticeStore {
    func reduce(state: State, mutate: Mutation) -> State {
        var newState = state
        switch mutate {
        case let .updateNoticeList(noticeList):
            newState.noticeList = noticeList
            let sections = self.noticeListToSections(noticeList: noticeList)
            newState.noticeSectionList = sections

        case let .updateCurrentUserRole(userRole):
            newState.currentUserRole = userRole

        case .toggleIsEditing:
            newState.isEditingMode.toggle()

        case let .insertSelectedNotice(noticeID):
            newState.selectedNotice.insert(noticeID)

        case let .removeSelectedNotice(noticeID):
            newState.selectedNotice.remove(noticeID)

        case .removeAllSelectedNotice:
            newState.selectedNotice.removeAll()
        }
        return newState
    }
}

private extension NoticeStore {
    func viewWillAppear() -> SideEffect<Mutation, Never> {
        return SideEffect<[NoticeModel], Error>
            .tryAsync { [fetchNoticeListUseCase] in
                try await fetchNoticeListUseCase()
            }
            .map(Mutation.updateNoticeList)
            .catchToNever()
            .eraseToSideEffect()
    }

    func viewDidLoad() -> SideEffect<Mutation, Never> {
        return SideEffect
            .just(try? loadCurrentUserRoleUseCase())
            .replaceNil(with: .member)
            .setFailureType(to: Never.self)
            .map(Mutation.updateCurrentUserRole)
            .eraseToSideEffect()
    }

    func noticeDidTap(noticeID: Int) -> SideEffect<Mutation, Never> {
        guard currentState.isEditingMode else {
            route.send(DotoriRoutePath.noticeDetail(noticeID: noticeID))
            return .none
        }
        let mutation = currentState.selectedNotice.contains(noticeID)
        ? Mutation.removeSelectedNotice(noticeID)
        : Mutation.insertSelectedNotice(noticeID)
        return .just(mutation)
    }

    func noticeListToSections(noticeList: [NoticeModel]) -> [SectiondNoticeTuple] {
        return noticeList.reduce(
            into: [SectiondNoticeTuple]()
        ) { partialResult, notice in
            let yearAndMonth = notice.createdTime
                .toStringWithCustomFormat(L10n.Notice.noticeSectionDateFormat)

            if let index = partialResult.firstIndex(where: { $0.section == yearAndMonth }) {
                var sectionTuple = partialResult[index]
                sectionTuple.noticeList.append(notice)
                partialResult[index] = sectionTuple
            } else {
                partialResult.append((yearAndMonth, [notice]))
            }
        }
    }
}
