import Moordinator

public struct NoticeFactoryImpl: NoticeFactory {
    public func makeMoordinator() -> Moordinator {
        NoticeMoordinator()
    }
}
