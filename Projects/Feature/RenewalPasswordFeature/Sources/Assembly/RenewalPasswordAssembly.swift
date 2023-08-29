import AuthDomainInterface
import RenewalPasswordFeatureInterface
import Swinject

public final class RenewalPasswordAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register(RenewalPasswordFactory.self) { _ in
            RenewalPasswordFactoryImpl()
        }
    }
}
