import DetailNoticeFeatureInterface
import NoticeDomainInterface
import Swinject
import UserDomainInterface

public final class DetailNoticeAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register(DetailNoticeFactory.self) { resolver in
            DetailNoticeFactoryImpl(
                fetchNoticeUseCase: resolver.resolve(FetchNoticeUseCase.self)!,
                removeNoticeUseCase: resolver.resolve(RemoveNoticeUseCase.self)!,
                loadCurrentUserRoleUseCase: resolver.resolve(LoadCurrentUserRoleUseCase.self)!
            )
        }
    }
}
