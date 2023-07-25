import BaseDomainInterface
import UserDomainInterface
import XCTest
@testable import UserDomainTesting
@testable import UserDomain
@testable import KeyValueStoreTesting

final class LogoutUseCaseTests: XCTestCase {
    var userRepository: UserRepositorySpy!
    var sut: LogoutUseCaseImpl!

    override func setUp() {
        super.setUp()
        userRepository = .init()
        sut = .init(userRepository: userRepository)
    }

    override func tearDown() {
        userRepository = nil
        sut = nil
    }

    func testLogout() {
        sut()

        XCTAssertEqual(userRepository.logoutCallCount, 1)
    }
}
