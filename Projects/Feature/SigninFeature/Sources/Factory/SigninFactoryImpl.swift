import SigninFeatureInterface
import Moordinator

public struct SigninFactoryImpl: SigninFactory {
    public func makeMoordinator() -> Moordinator {
        SigninMoordinator()
    }
}
