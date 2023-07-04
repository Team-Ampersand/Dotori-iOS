import Foundation
import UserDomainInterface

struct LoadCurrentUserRoleUseCaseImpl: LoadCurrentUserRoleUseCase {
    private let userRepository: any UserRepository

    init(userRepository: any UserRepository){
        self.userRepository = userRepository
    }

    func callAsFunction() throws -> UserRoleType {
        try userRepository.loadCurrentUserRole()
    }
}
