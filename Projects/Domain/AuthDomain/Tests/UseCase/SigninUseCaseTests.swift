@testable import AuthDomain
import AuthDomainInterface
@testable import AuthDomainTesting
import XCTest

final class SigninUseCaseTests: XCTestCase {
    var authRepository: AuthRepositorySpy!
    var sut: SigninUseCaseImpl!

    override func setUp() {
        authRepository = .init()
        sut = .init(authRepository: authRepository)
    }

    override func tearDown() {
        authRepository = nil
        sut = nil
    }

    func test_Signin() async throws {
        try await sut.execute(req: .init(
                email: "s00000@gsm.hs.kr",
                password: "12345678"
            )
        )

        XCTAssertEqual(authRepository.signinCallCount, 1)
    }
}
