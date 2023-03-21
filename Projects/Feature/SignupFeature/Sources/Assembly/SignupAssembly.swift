import AuthDomainInterface
import SignupFeatureInterface
import Swinject

public final class SignupAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register(SignupFactory.self) { resolver in
            SignupFactoryImpl(
                loadJwtTokenUseCase: resolver.resolve(LoadJwtTokenUseCase.self)!
            )
        }
    }
}
