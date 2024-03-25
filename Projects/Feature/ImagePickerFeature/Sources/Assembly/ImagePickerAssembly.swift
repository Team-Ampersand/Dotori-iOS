import ImagePickerFeatureInterface
import Swinject
import UserDomainInterface

public final class ImagePickerAssembly: Assembly {
    public init() {}

    public func assemble(container: Container) {
        container.register(ImagePickerFactory.self) { resolver in
            ImagePickerFactoryImpl()
        }
    }
}
