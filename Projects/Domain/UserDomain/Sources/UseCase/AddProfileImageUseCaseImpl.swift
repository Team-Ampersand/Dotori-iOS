import Foundation
import UserDomainInterface

struct AddProfileImageUseCaseImpl: AddProfileImageUseCase {
    private let userRepository: any UserRepository

    init(userRepository: any UserRepository) {
        self.userRepository = userRepository
    }

    func callAsFunction(profileImage: Data) async throws {
        try await userRepository.addProfileImage(image: profileImage)
    }
}
