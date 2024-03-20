@testable import UserDomain
@testable import UserDomainTesting
import XCTest

final class UserRepositoryTests: XCTestCase {
    var userRepository: UserRepositoryImpl!
    var remoteUserDataSourceSpy: RemoteUserDataSourceSpy!
    var localUserDataSourceSpy: LocalUserDataSourceSpy!
    var remoteHomeDataSourceSpy: RemoteHomeDataSourceSpy!

    override func setUp() {
        super.setUp()
        remoteUserDataSourceSpy = .init()
        localUserDataSourceSpy = LocalUserDataSourceSpy()
        remoteUserDataSourceSpy = RemoteUserDataSourceSpy()
        remoteHomeDataSourceSpy = RemoteHomeDataSourceSpy()
        userRepository = UserRepositoryImpl(
            localUserDataSource: localUserDataSourceSpy,
            remoteUserDataSource: remoteUserDataSourceSpy,
            remoteHomeDataSource: remoteHomeDataSourceSpy
        )
    }

    override func tearDown() {
        userRepository = nil
        localUserDataSourceSpy = nil
        remoteUserDataSourceSpy = nil
        remoteHomeDataSourceSpy = nil
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
