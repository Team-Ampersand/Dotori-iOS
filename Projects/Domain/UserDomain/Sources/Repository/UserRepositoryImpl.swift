import BaseDomainInterface
import Foundation
import UserDomainInterface

final class UserRepositoryImpl: UserRepository {
    private let localUserDataSource: any LocalUserDataSource

    init(localUserDataSource: any LocalUserDataSource) {
        self.localUserDataSource = localUserDataSource
    }

    func loadCurrentUserRole() throws -> UserRoleType {
        try localUserDataSource.loadCurrentUserRole()
    }

    func logout() {
        localUserDataSource.logout()
    }
}
