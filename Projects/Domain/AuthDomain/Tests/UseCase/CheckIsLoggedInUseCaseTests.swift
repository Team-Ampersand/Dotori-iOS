import AuthDomainInterface
import XCTest
@testable import AuthDomain
@testable import AuthDomainTesting

final class CheckIsLoggedInUseCaseTests: XCTestCase {
    var authRepository: AuthRepositorySpy!
    var sut: CheckIsLoggedInUseCaseImpl!

    override func setUp() {
        authRepository = .init()
        sut = .init(authRepository: authRepository)
    }

    override func tearDown() {
        authRepository = nil
        sut = nil
    }

    func test_CheckIsLoggedInTrue_NetworkConnectedTrue_And_RefreshSuccess() async {
        authRepository.networkIsConnectedReturn = true
        authRepository.checkTokenIsExistReturn = true

        let checkIsLoggedIn = await sut()

        XCTAssertEqual(checkIsLoggedIn, true)
        XCTAssertEqual(authRepository.networkIsConnectedCallCount, 1)
        // When Network is Connected, checkTokenIsExist not call
        XCTAssertEqual(authRepository.checkTokenIsExistCallCount, 0)
    }

    func test_CheckIsLoggedInTrue_NetworkConnectedTrue_And_RefreshFailure() async {
        authRepository.networkIsConnectedReturn = true
        authRepository.checkTokenIsExistReturn = true
        let refreshError = AuthDomainError.refreshTokenExpired
        authRepository.tokenRefreshThrowingError = refreshError

        let checkIsLoggedIn = await sut()

        XCTAssertEqual(checkIsLoggedIn, false)
        XCTAssertEqual(authRepository.networkIsConnectedCallCount, 1)
        // When Network is Connected, checkTokenIsExist not call
        XCTAssertEqual(authRepository.checkTokenIsExistCallCount, 0)
    }

    func test_CheckIsLoggedInTrue_NetworkConnectedFalse_And_TokenExistTrue() async {
        authRepository.networkIsConnectedReturn = false
        authRepository.checkTokenIsExistReturn = true

        let checkIsLoggedIn = await sut()

        XCTAssertEqual(checkIsLoggedIn, true)
        XCTAssertEqual(authRepository.networkIsConnectedCallCount, 1)
        XCTAssertEqual(authRepository.checkTokenIsExistCallCount, 1)
    }

    func test_CheckIsLoggedInTrue_NetworkConnectedFalse_And_TokenExistFalse() async {
        authRepository.networkIsConnectedReturn = false
        authRepository.checkTokenIsExistReturn = false

        let checkIsLoggedIn = await sut()

        XCTAssertEqual(checkIsLoggedIn, false)
        XCTAssertEqual(authRepository.networkIsConnectedCallCount, 1)
        XCTAssertEqual(authRepository.checkTokenIsExistCallCount, 1)
    }
}
