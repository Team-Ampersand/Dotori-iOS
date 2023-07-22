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
    }
    enum Action {
        case viewDidLoad
    }
    enum Mutation {
        case updateNoticeList([NoticeModel])
        case updateCurrentUserRole(UserRoleType)
    }
}

extension NoticeStore {
    func mutate(state: State, action: Action) -> SideEffect<Mutation, Never> {
        switch action {
        case .viewDidLoad:
            return viewDidLoad()
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
        }
        return newState
    }
}

private extension NoticeStore {
    func viewDidLoad() -> SideEffect<Mutation, Never> {
        let noticeSideEffect = SideEffect<[NoticeModel], Error>
            .tryAsync { [fetchNoticeListUseCase] in
                try await fetchNoticeListUseCase()
            }
            .map(Mutation.updateNoticeList)
            .catchToNever()
            .eraseToSideEffect()

        let userRoleSideEffect = SideEffect
            .just(try? loadCurrentUserRoleUseCase())
            .replaceNil(with: .member)
            .setFailureType(to: Never.self)
            .map(Mutation.updateCurrentUserRole)
            .eraseToSideEffect()

        return .merge(
            noticeSideEffect,
            userRoleSideEffect
        )
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
