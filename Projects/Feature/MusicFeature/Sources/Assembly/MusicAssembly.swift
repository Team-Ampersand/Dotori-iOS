import MusicDomainInterface
import Swinject
import UserDomainInterface

public final class MusicAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register(MusicFactory.self) { resolver in
            MusicFactoryImpl(
                fetchMusicListUseCase: resolver.resolve(FetchMusicListUseCase.self)!,
                removeMusicUseCase: resolver.resolve(RemoveMusicUseCase.self)!,
                loadCurrentUserRoleUseCase: resolver.resolve(LoadCurrentUserRoleUseCase.self)!
            )
        }
    }
}
