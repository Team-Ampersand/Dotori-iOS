import XCTest
@testable import UserDomainTesting
@testable import UserDomain

class LoadCurrentUserRoleUseCaseTests: XCTestCase {
    var loadCurrentUserRoleUseCase: LoadCurrentUserRoleUseCaseImpl!
    var userRepositorySpy: UserRepositorySpy!

    override func setUp() {
        super.setUp()
        userRepositorySpy = UserRepositorySpy()
        loadCurrentUserRoleUseCase = LoadCurrentUserRoleUseCaseImpl(userRepository: userRepositorySpy)
    }

    override func tearDown() {
        loadCurrentUserRoleUseCase = nil
        userRepositorySpy = nil
        super.tearDown()
    }

    func testCallAsFunction() {
        // Given
        userRepositorySpy.loadCurrentUserRoleReturn = .member

        // When
        do {
            let currentUserRole = try loadCurrentUserRoleUseCase()

            // Then
            XCTAssertEqual(
                userRepositorySpy.loadCurrentUserRoleCallCount,
                1,
                "loadCurrentUserRole should be called once"
            )
            XCTAssertEqual(
                currentUserRole,
                .member,
                "The returned currentUserRole should be .admin"
            )
        } catch {
            XCTFail("Unexpected error thrown: \(error)")
        }
    }
}
