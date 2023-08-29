import MusicDomainInterface
import ProposeMusicFeatureInterface
import Swinject

public final class ProposeMusicAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register(ProposeMusicFactory.self) { resolver in
            ProposeMusicFactoryImpl(
                proposeMusicUseCase: resolver.resolve(ProposeMusicUseCase.self)!
            )
        }
    }
}
