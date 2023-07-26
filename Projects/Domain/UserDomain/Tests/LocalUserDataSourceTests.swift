import BaseDomainInterface
import UserDomainInterface
import XCTest
@testable import UserDomainTesting
@testable import UserDomain
@testable import KeyValueStoreTesting
@testable import JwtStoreTesting

final class LocalUserDataSourceTests: XCTestCase {
    var localUserDataSource: LocalUserDataSourceImpl!
    var keyValueStoreFake: DictionaryKeyValueStore!
    var jwtStore: DictionaryJwtStore!

    override func setUp() {
        super.setUp()
        keyValueStoreFake = DictionaryKeyValueStore()
        jwtStore = .init()
        localUserDataSource = LocalUserDataSourceImpl(
            keyValueStore: keyValueStoreFake,
            jwtStore: jwtStore
        )
    }

    override func tearDown() {
        localUserDataSource = nil
        keyValueStoreFake = nil
        jwtStore = nil
    }

    func testLoadCurrentUserRole_Success() {
        // Given
        keyValueStoreFake.save(key: .userRole, value: UserRoleType.member.rawValue)

        // When
        do {
            let currentUserRole = try localUserDataSource.loadCurrentUserRole()

            // Then
            XCTAssertEqual(
                currentUserRole,
                .member,
                "The returned currentUserRole should be .admin"
            )
        } catch {
            XCTFail("Unexpected error thrown: \(error)")
        }
    }

    func testLoadCurrentUserRole_ThrowsError() {
        // When
        do {
            _ = try localUserDataSource.loadCurrentUserRole()

            // Then
            XCTFail("Expected error UserDomainError.cannotFindUserRole not thrown")
        } catch {
            // Then
            XCTAssertEqual(
                error as? UserDomainError,
                UserDomainError.cannotFindUserRole,
                "Unexpected error type"
            )
        }
    }
}
