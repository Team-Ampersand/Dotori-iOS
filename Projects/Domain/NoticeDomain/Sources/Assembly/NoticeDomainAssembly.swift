import NetworkingInterface
import NoticeDomainInterface
import Swinject

public final class NoticeDomainAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register(RemoteNoticeDataSource.self) { resolver in
            RemoteNoticeDataSourceImpl(networking: resolver.resolve(Networking.self)!)
        }
        .inObjectScope(.container)

        container.register(NoticeRepository.self) { resolver in
            NoticeRepositoryImpl(remoteNoticeDataSource: resolver.resolve(RemoteNoticeDataSource.self)!)
        }
        .inObjectScope(.container)

        container.register(FetchNoticeListUseCase.self) { resolver in
            FetchNoticeListUseCaseImpl(noticeRepository: resolver.resolve(NoticeRepository.self)!)
        }

        container.register(FetchNoticeUseCase.self) { resolver in
            FetchNoticeUseCaseImpl(noticeRepository: resolver.resolve(NoticeRepository.self)!)
        }

        container.register(RemoveNoticeUseCase.self) { resolver in
            RemoveNoticeUseCaseImpl(noticeRepository: resolver.resolve(NoticeRepository.self)!)
        }
    }
}
