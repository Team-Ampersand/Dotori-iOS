import BaseFeature
import BaseFeatureInterface
import ProfileImageFeatureInterface
import UserDomainInterface

struct ProfileImageFactoryImpl: ProfileImageFactory {
    private let addProfileImageUseCase: any AddProfileImageUseCase
    private let editProfileImageUseCase: any EditProfileImageUseCase
    private let deleteProfileImageUseCase: any DeleteProfileImageUseCase

    init(
        addProfileImageUseCase: any AddProfileImageUseCase,
        editProfileImageUseCase: any EditProfileImageUseCase,
        deleteProfileImageUseCase: any DeleteProfileImageUseCase
    ) {
        self.addProfileImageUseCase = addProfileImageUseCase
        self.editProfileImageUseCase = editProfileImageUseCase
        self.deleteProfileImageUseCase = deleteProfileImageUseCase
    }

    func makeViewController() -> any RoutedViewControllable {
        let store = ProfileImageStore(
            addProfileImageUseCase: addProfileImageUseCase,
            editProfileImageUseCase: editProfileImageUseCase,
            deleteProfileImageUseCase: deleteProfileImageUseCase
        )
        return ProfileImageViewController(store: store)
    }
}
