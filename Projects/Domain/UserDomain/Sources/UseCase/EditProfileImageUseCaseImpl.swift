import Foundation
import UserDomainInterface

struct EditProfileImageUseCaseImpl: EditProfileImageUseCase {
    private let userRepository: any UserRepository

    init(userRepository: any UserRepository) {
        self.userRepository = userRepository
    }

    func callAsFunction(profileImage: Data) async throws {
        try await userRepository.editProfileImage(image: profileImage)
    }
}
