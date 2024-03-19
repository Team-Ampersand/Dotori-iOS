import ProfileImageFeatureInterface
import Swinject
import UserDomainInterface

public final class ProfileImageAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register(ProfileImageFactory.self) { resolver in
            ProfileImageFactoryImpl(
                fetchProfileImageUseCase: resolver.resolve(FetchProfileImageUseCase.self)!,
                addProfileImageUseCase: resolver.resolve(AddProfileImageUseCase.self)!,
                deleteProfileImageUseCase: resolver.resolve(DeleteProfileImageUseCase.self)!
            )
        }
    }
}
