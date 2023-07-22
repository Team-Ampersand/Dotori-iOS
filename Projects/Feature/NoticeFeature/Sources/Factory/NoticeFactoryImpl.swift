import Moordinator
import NoticeDomainInterface
import UserDomainInterface

struct NoticeFactoryImpl: NoticeFactory {
    private let fetchNoticeListUseCase: any FetchNoticeListUseCase
    private let loadCurrentUserRoleUseCase: any LoadCurrentUserRoleUseCase

    init(
        fetchNoticeListUseCase: any FetchNoticeListUseCase,
        loadCurrentUserRoleUseCase: any LoadCurrentUserRoleUseCase
    ) {
        self.fetchNoticeListUseCase = fetchNoticeListUseCase
        self.loadCurrentUserRoleUseCase = loadCurrentUserRoleUseCase
    }

    func makeMoordinator() -> Moordinator {
        let noticeStore = NoticeStore(
            fetchNoticeListUseCase: fetchNoticeListUseCase,
            loadCurrentUserRoleUseCase: loadCurrentUserRoleUseCase
        )
        let noticeViewController = NoticeViewController(store: noticeStore)
        return NoticeMoordinator(noticeViewController: noticeViewController)
    }
}
