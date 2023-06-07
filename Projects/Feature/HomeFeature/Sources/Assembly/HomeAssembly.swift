import AuthDomainInterface
import Swinject

public final class HomeAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register(HomeFactory.self) { resolver in
            HomeFactoryImpl(loadJwtTokenUseCase: resolver.resolve(LoadJwtTokenUseCase.self)!)
        }
    }
}
