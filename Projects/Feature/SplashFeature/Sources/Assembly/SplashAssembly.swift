import AuthDomainInterface
import SplashFeatureInterface
import Swinject

public final class SplashAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register(SplashFactory.self) { resolver in
            SplashFactoryImpl(checkIsLoggedInUseCase: resolver.resolve(CheckIsLoggedInUseCase.self)!)
        }
    }
}
