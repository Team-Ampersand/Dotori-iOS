import BaseFeature
import BaseFeatureInterface
import ProfileImageFeatureInterface
import UserDomainInterface

struct ProfileImageFactoryImpl: ProfileImageFactory {
    private let fetchProfileImageUseCase: any FetchProfileImageUseCase
    private let addProfileImageUseCase: any AddProfileImageUseCase
    private let deleteProfileImageUseCase: any DeleteProfileImageUseCase

    init(
        fetchProfileImageUseCase: any FetchProfileImageUseCase,
        addProfileImageUseCase: any AddProfileImageUseCase,
        deleteProfileImageUseCase: any DeleteProfileImageUseCase
    ) {
        self.fetchProfileImageUseCase = fetchProfileImageUseCase
        self.addProfileImageUseCase = addProfileImageUseCase
        self.deleteProfileImageUseCase = deleteProfileImageUseCase
    }

    func makeViewController() -> any RoutedViewControllable {
        let store = ProfileImageStore(
            fetchProfileImageUseCase: fetchProfileImageUseCase,
            addProfileImageUseCase: addProfileImageUseCase,
            deleteProfileImageUseCase: deleteProfileImageUseCase
        )
        return ProfileImageViewController(store: store)
    }
}
