import Swinject

public final class ConfirmationDialogAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register(ConfirmationDialogFactory.self) { _ in
            ConfirmationDialogFactoryImpl()
        }
    }
}
