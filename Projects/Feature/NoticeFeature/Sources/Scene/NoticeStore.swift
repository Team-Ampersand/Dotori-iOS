import BaseFeature
import Combine
import DateUtility
import Foundation
import Moordinator
import NoticeDomainInterface
import Store

final class NoticeStore: BaseStore {
    var route: PassthroughSubject<RoutePath, Never> = .init()
    var subscription: Set<AnyCancellable> = .init()
    var initialState: State
    var stateSubject: CurrentValueSubject<State, Never>
    private let fetchNoticeListUseCase: any FetchNoticeListUseCase

    init(fetchNoticeListUseCase: any FetchNoticeListUseCase) {
        initialState = .init()
        stateSubject = .init(initialState)
        self.fetchNoticeListUseCase = fetchNoticeListUseCase
    }

    struct State {
        var noticeList: [NoticeModel] = []
        var sectionsByYearAndMonth: [(String, [NoticeModel])] = []
    }
    enum Action {
        case viewDidLoad
    }
    enum Mutation {
        case updateNoticeList([NoticeModel])
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
            let sections = noticeList.reduce(
                into: [(String, [NoticeModel])]()
            ) { partialResult, notice in
                let yearAndMonth = notice.createdTime.toStringWithCustomFormat("yyyy년 MM월")

                if let index = partialResult.firstIndex(where: { $0.0 == yearAndMonth }) {
                    var sectionTuple = partialResult[index]
                    sectionTuple.1.append(notice)
                    partialResult[index] = sectionTuple
                } else {
                    partialResult.append((yearAndMonth, [notice]))
                }
            }

            newState.sectionsByYearAndMonth = sections
        }
        return newState
    }
}

private extension NoticeStore {
    func viewDidLoad() -> SideEffect<Mutation, Never> {
        return SideEffect<[NoticeModel], Error>
            .tryAsync { [fetchNoticeListUseCase] in
                try await fetchNoticeListUseCase()
            }
            .map(Mutation.updateNoticeList)
            .catchToNever()
            .eraseToSideEffect()
    }
}
