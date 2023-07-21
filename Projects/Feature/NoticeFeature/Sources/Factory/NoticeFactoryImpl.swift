import Moordinator
import NoticeDomainInterface

struct NoticeFactoryImpl: NoticeFactory {
    private let fetchNoticeListUseCase: any FetchNoticeListUseCase

    init(fetchNoticeListUseCase: any FetchNoticeListUseCase) {
        self.fetchNoticeListUseCase = fetchNoticeListUseCase
    }

    func makeMoordinator() -> Moordinator {
        let noticeStore = NoticeStore(fetchNoticeListUseCase: fetchNoticeListUseCase)
        let noticeViewController = NoticeViewController(store: noticeStore)
        return NoticeMoordinator(noticeViewController: noticeViewController)
    }
}
