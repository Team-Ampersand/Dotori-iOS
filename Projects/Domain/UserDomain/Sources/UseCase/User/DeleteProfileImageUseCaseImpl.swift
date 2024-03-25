import Foundation
import UserDomainInterface

struct DeleteProfileImageUseCaseImpl: DeleteProfileImageUseCase {
    private let userRepository: any UserRepository

    init(userRepository: any UserRepository) {
        self.userRepository = userRepository
    }

    func callAsFunction() async throws {
        try await userRepository.deleteProfileImage()
    }
}
