@testable import AuthDomain
import AuthDomainInterface
@testable import AuthDomainTesting
import XCTest

final class AuthRepositoryTests: XCTestCase {
    var remoteAuthDataSource: RemoteAuthDataSourceSpy!
    var localAuthDataSource: LocalAuthDataSourceSpy!
    var sut: AuthRepositoryImpl!

    override func setUp() {
        remoteAuthDataSource = .init()
        localAuthDataSource = .init()
        sut = .init(
            remoteAuthDataSource: remoteAuthDataSource,
            localAuthDataSource: localAuthDataSource
        )
    }

    override func tearDown() {
        remoteAuthDataSource = nil
        localAuthDataSource = nil
        sut = nil
    }

    func test_signin() async throws {
        XCTAssertEqual(remoteAuthDataSource.signinCallCount, 0)

        let req = SigninRequestDTO(email: "s00000@gsm.hs.kr", password: "12345678")
        try await sut.signin(req: req)

        XCTAssertEqual(remoteAuthDataSource.signinCallCount, 1)
    }

    func test_loadJwtToken() {
        let expected = JwtTokenEntity(
            accessToken: "access",
            refreshToken: "refresh",
            expiresAt: "expires"
        )
        XCTAssertEqual(localAuthDataSource.loadJwtTokenCallCount, 0)

        let actual = sut.loadJwtToken()

        XCTAssertEqual(localAuthDataSource.loadJwtTokenCallCount, 1)
        XCTAssertEqual(actual, expected)
    }

    func test_tokenRefresh() async throws {
        XCTAssertEqual(remoteAuthDataSource.tokenRefreshCallCount, 0)

        try await sut.tokenRefresh()

        XCTAssertEqual(remoteAuthDataSource.tokenRefreshCallCount, 1)
    }

    func test_checkTokenIsExist() {
        let expected = Bool()
        XCTAssertEqual(localAuthDataSource.checkTokenIsExistCallCount, 0)

        let actual = sut.checkTokenIsExist()

        XCTAssertEqual(localAuthDataSource.checkTokenIsExistCallCount, 1)
        XCTAssertEqual(actual, expected)
    }

    func test_networkIsConnected() async {
        let expected = Bool()
        XCTAssertEqual(remoteAuthDataSource.networkIsConnectedCallCount, 0)

        let actual = await sut.networkIsConnected()

        XCTAssertEqual(remoteAuthDataSource.networkIsConnectedCallCount, 1)
        XCTAssertEqual(actual, expected)
    }
}
