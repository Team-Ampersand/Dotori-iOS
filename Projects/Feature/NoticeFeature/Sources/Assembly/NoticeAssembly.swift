import DetailNoticeFeature
import NoticeDomainInterface
import Swinject
import UserDomainInterface

public final class NoticeAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register(NoticeFactory.self) { resolver in
            NoticeFactoryImpl(
                fetchNoticeListUseCase: resolver.resolve(FetchNoticeListUseCase.self)!,
                loadCurrentUserRoleUseCase: resolver.resolve(LoadCurrentUserRoleUseCase.self)!,
                detailNoticeFactory: resolver.resolve(DetailNoticeFactory.self)!
            )
        }
    }
}
