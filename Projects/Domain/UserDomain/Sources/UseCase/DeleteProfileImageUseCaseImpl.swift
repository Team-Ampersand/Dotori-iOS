import Foundation
import UserDomainInterface

struct DeleteProfileImageUseCaseImpl: DeleteProfileImageUseCase {
    private let userRepository: any UserRepository

    init(userRepository: any UserRepository) {
        self.userRepository = userRepository
    }

    func callAsFunction(profileImage: Data) async throws {
        try await userRepository.deleteProfileImage(image: profileImage)
    }
}
