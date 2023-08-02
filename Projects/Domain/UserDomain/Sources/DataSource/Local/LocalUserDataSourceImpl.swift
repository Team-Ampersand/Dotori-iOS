import BaseDomainInterface
import Foundation
import JwtStoreInterface
import KeyValueStoreInterface
import UserDomainInterface

final class LocalUserDataSourceImpl: LocalUserDataSource {
    private let keyValueStore: any KeyValueStore
    private let jwtStore: any JwtStore

    init(
        keyValueStore: any KeyValueStore,
        jwtStore: any JwtStore
    ) {
        self.keyValueStore = keyValueStore
        self.jwtStore = jwtStore
    }

    func loadCurrentUserRole() throws -> UserRoleType {
        guard let userRoleString = keyValueStore.load(key: .userRole) as? String,
              let userRole = UserRoleType(rawValue: userRoleString)
        else {
            throw UserDomainError.cannotFindUserRole
        }
        return userRole
    }

    func logout() {
        jwtStore.delete(property: .accessToken)
        jwtStore.delete(property: .refreshToken)
        jwtStore.delete(property: .accessExpiresAt)
    }
}
