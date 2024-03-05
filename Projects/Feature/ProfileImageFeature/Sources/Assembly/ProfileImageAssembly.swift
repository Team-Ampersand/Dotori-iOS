import ProfileImageFeatureInterface
import Swinject
import UserDomainInterface

public final class ProfileImageAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register(ProfileImageFactory.self) { resolver in
            ProfileImageFactoryImpl(
                addProfileImageUseCase: resolver.resolve(AddProfileImageUseCase.self)!,
                editProfileImageUseCase: resolver.resolve(EditProfileImageUseCase.self)!,
                deleteProfileImageUseCase: resolver.resolve(DeleteProfileImageUseCase.self)!
            )
        }
    }
}
