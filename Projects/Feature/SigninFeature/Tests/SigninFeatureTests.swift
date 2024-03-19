@testable import AuthDomainTesting
import BaseFeature
import Combine
import Moordinator
@testable import SigninFeature
import XCTest

final class SigninFeatureTests: XCTestCase {
    var signinUseCase: SigninUseCaseSpy!
    var sut: SigninStore!
    var subscriptions: Set<AnyCancellable>!

    override func setUp() {
        signinUseCase = .init()
        sut = .init(signinUseCase: signinUseCase)
        subscriptions = .init()
    }

    override func tearDown() {
        signinUseCase = nil
        sut = nil
        subscriptions = nil
    }

    func testSigninButtonDidTap() {
        let email = "s00000@gsm.hs.kr"
        sut.send(.updateEmail(email))
        XCTAssertEqual(sut.currentState.email, email)

        let password = "12345678"
        sut.send(.updatePassword(password))
        XCTAssertEqual(sut.currentState.password, password)

        sut.send(.signinButtonDidTap)
    }
}
