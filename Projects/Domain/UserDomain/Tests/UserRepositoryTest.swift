import XCTest
@testable import UserDomainTesting
@testable import UserDomain

final class UserRepositoryTests: XCTestCase {
    var userRepository: UserRepositoryImpl!
    var remoteUserDataSourceSpy: RemoteUserDataSourceSpy!
    var localUserDataSourceSpy: LocalUserDataSourceSpy!

    override func setUp() {
        super.setUp()
        remoteUserDataSourceSpy = .init()
        localUserDataSourceSpy = LocalUserDataSourceSpy()
        userRepository = UserRepositoryImpl(
            localUserDataSource: localUserDataSourceSpy,
            remoteUserDataSource: remoteUserDataSourceSpy
        )
    }

    override func tearDown() {
        userRepository = nil
        localUserDataSourceSpy = nil
        remoteUserDataSourceSpy = nil
        super.tearDown()
    }

    func testLoadCurrentUserRole() {
        // Given
        localUserDataSourceSpy.loadCurrentUserRoleReturn = .member

        // When
        do {
            let currentUserRole = try userRepository.loadCurrentUserRole()

            // Then
            XCTAssertEqual(
                localUserDataSourceSpy.loadCurrentUserRoleCallCount,
                1,
                "loadCurrentUserRole should be called once"
            )
            XCTAssertEqual(
                currentUserRole,
                .member,
                "The returned currentUserRole should be .member"
            )
        } catch {
            XCTFail("Unexpected error thrown: \(error)")
        }
    }
}
