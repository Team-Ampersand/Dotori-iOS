import MainFeatureInterface
import Swinject

public final class MainAssembly: Assembly {
    public init() { }
    public func assemble(container: Container) {
        container.register(MainFactory.self) { _ in
            MainFactoryImpl()
        }
    }
}
