import Moordinator

struct NoticeFactoryImpl: NoticeFactory {
    func makeMoordinator() -> Moordinator {
        NoticeMoordinator()
    }
}
