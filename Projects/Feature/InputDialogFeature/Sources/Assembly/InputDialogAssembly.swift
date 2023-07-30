import InputDialogFeatureInterface
import Swinject

public final class InputDialogAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register(InputDialogFactory.self) { resolver in
            InputDialogFactoryImpl()
        }
    }
}
