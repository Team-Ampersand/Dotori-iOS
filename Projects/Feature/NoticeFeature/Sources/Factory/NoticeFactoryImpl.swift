import DetailNoticeFeature
import Moordinator
import NoticeDomainInterface
import UserDomainInterface

struct NoticeFactoryImpl: NoticeFactory {
    private let fetchNoticeListUseCase: any FetchNoticeListUseCase
    private let loadCurrentUserRoleUseCase: any LoadCurrentUserRoleUseCase
    private let detailNoticeFactory: any DetailNoticeFactory

    init(
        fetchNoticeListUseCase: any FetchNoticeListUseCase,
        loadCurrentUserRoleUseCase: any LoadCurrentUserRoleUseCase,
        detailNoticeFactory: any DetailNoticeFactory
    ) {
        self.fetchNoticeListUseCase = fetchNoticeListUseCase
        self.loadCurrentUserRoleUseCase = loadCurrentUserRoleUseCase
        self.detailNoticeFactory = detailNoticeFactory
    }

    func makeMoordinator() -> Moordinator {
        let noticeStore = NoticeStore(
            fetchNoticeListUseCase: fetchNoticeListUseCase,
            loadCurrentUserRoleUseCase: loadCurrentUserRoleUseCase
        )
        let noticeViewController = NoticeViewController(store: noticeStore)
        return NoticeMoordinator(
            noticeViewController: noticeViewController,
            detailNoticeFactory: detailNoticeFactory
        )
    }
}
