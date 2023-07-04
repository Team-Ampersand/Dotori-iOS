import Foundation
import KeyValueStoreInterface
import UserDomainInterface

final class LocalUserDataSourceImpl: LocalUserDataSource {
    private let keyValueStore: any KeyValueStore

    init(keyValueStore: any KeyValueStore) {
        self.keyValueStore = keyValueStore
    }

    func loadCurrentUserRole() throws -> UserRoleType {
        guard let userRoleString = keyValueStore.load(key: .userRole) as? String,
              let userRole = UserRoleType(rawValue: userRoleString)
        else {
            throw UserDomainError.cannotFindUserRole
        }
        return userRole
    }
}
