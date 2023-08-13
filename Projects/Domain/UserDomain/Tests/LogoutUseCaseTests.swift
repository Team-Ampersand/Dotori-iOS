import BaseDomainInterface
@testable import KeyValueStoreTesting
@testable import UserDomain
import UserDomainInterface
@testable import UserDomainTesting
import XCTest

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
