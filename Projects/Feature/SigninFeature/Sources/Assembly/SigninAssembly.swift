import AuthDomainInterface
import RenewalPasswordFeatureInterface
import SigninFeatureInterface
import SignupFeatureInterface
import Swinject

public final class SigninAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register(SigninFactory.self) { resolver in
            SigninFactoryImpl(
                signinUseCase: resolver.resolve(SigninUseCase.self)!,
                signupFactory: resolver.resolve(SignupFactory.self)!,
                renewalPasswordFactory: resolver.resolve(RenewalPasswordFactory.self)!
            )
        }
    }
}
