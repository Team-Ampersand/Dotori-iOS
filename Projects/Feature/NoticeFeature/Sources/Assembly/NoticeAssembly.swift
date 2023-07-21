import NoticeDomainInterface
import Swinject

public final class NoticeAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register(NoticeFactory.self) { resolver in
            NoticeFactoryImpl(fetchNoticeListUseCase: resolver.resolve(FetchNoticeListUseCase.self)!)
        }
    }
}
