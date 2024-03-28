@testable import AuthDomainTesting
import BaseFeature
import Combine
import Moordinator
@testable import SigninFeature
import XCTest

final class SigninFeatureTests: XCTestCase {
    var signinUseCase: SigninUseCaseSpy!
    var sut: SigninStore!
    var subscription: Set<AnyCancellable>!

    override func setUp() {
        signinUseCase = .init()
        sut = .init(signinUseCase: signinUseCase)
        subscription = .init()
    }

    override func tearDown() {
        signinUseCase = nil
        sut = nil
        subscription = nil
    }

    func testSigninButtonDidTap() {
        let email = "s00000@gsm.hs.kr"
        sut.send(.updateEmail(email))
        XCTAssertEqual(sut.currentState.email, email)

        let password = "12345678"
        sut.send(.updatePassword(password))
        XCTAssertEqual(sut.currentState.password, password)

        let expectation = XCTestExpectation(description: "route expectation")

        var mainRoutePath: RoutePath?
        sut.route.sink { routePath in
            mainRoutePath = routePath
            expectation.fulfill()
        }
        .store(in: &subscription)

        sut.send(.signinButtonDidTap)

        wait(for: [expectation], timeout: 1.0)
        guard
            let mainRoutePath = mainRoutePath?.asDotori,
            case .main = mainRoutePath
        else {
            XCTFail("mainRoutePath is not DotoriRoutePath.main")
            return
        }
    }
}
