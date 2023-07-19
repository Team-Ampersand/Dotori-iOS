import Moordinator

struct NoticeFactoryImpl: NoticeFactory {
    func makeMoordinator() -> Moordinator {
        let noticeStore = NoticeStore()
        let noticeViewController = NoticeViewController(store: noticeStore)
        return NoticeMoordinator(noticeViewController: noticeViewController)
    }
}
