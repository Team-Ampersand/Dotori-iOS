import BaseFeature
import Combine
import Moordinator
import XCTest
@testable import SplashFeature
@testable import AuthDomainTesting

final class SplashFeatureTests: XCTestCase {
    var checkIsLoggedInUseCase: CheckIsLoggedInUseCaseSpy!
    var sut: SplashStore!
    var subscriptions: Set<AnyCancellable>!

    override func setUp() {
        checkIsLoggedInUseCase = .init()
        sut = .init(checkIsLoggedInUseCase: checkIsLoggedInUseCase)
        subscriptions = .init()
    }

    override func tearDown() {
        checkIsLoggedInUseCase = nil
        sut = nil
        subscriptions = nil
    }

    func test_IsLoggedInTrue_Route_Main() {
        let expectation = XCTestExpectation(description: "expectation for route to be main")
        var latestRoutePath: RoutePath?
        sut.route.sink {
            latestRoutePath = $0
            expectation.fulfill()
        }
        .store(in: &subscriptions)

        checkIsLoggedInUseCase.checkIsLoggedInReturn = true
        sut.send(.viewDidLoad)

        wait(for: [expectation], timeout: 1)

        guard let latestRoutePath = latestRoutePath?.asDotori,
              case DotoriRoutePath.main = latestRoutePath
        else {
            XCTFail("latestRoutePath is not main")
            return
        }
    }

    func test_IsLoggedInFalse_Route_Signin() {
        let expectation = XCTestExpectation(description: "expectation for route to be main")
        var latestRoutePath: RoutePath?
        sut.route.sink {
            latestRoutePath = $0
            expectation.fulfill()
        }
        .store(in: &subscriptions)

        checkIsLoggedInUseCase.checkIsLoggedInReturn = false
        sut.send(.viewDidLoad)

        wait(for: [expectation], timeout: 1)

        guard let latestRoutePath = latestRoutePath?.asDotori,
              case DotoriRoutePath.signin = latestRoutePath
        else {
            XCTFail("latestRoutePath is not signin")
            return
        }
    }
}
