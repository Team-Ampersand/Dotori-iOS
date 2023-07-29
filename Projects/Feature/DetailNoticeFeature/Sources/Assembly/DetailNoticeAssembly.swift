import Swinject
import NoticeDomainInterface

public final class DetailNoticeAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register(DetailNoticeFactory.self) { resolver in
            DetailNoticeFactoryImpl(
                fetchNoticeUseCase: resolver.resolve(FetchNoticeUseCase.self)!
            )
        }
    }
}
