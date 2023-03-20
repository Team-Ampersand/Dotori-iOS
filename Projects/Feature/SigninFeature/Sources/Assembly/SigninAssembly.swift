import SigninFeatureInterface
import Swinject

public final class SigninAssembly: Assembly {
    public init() { }
    public func assemble(container: Container) {
        container.register(SigninFactory.self) { _ in
            SigninFactoryImpl()
        }
    }
}
