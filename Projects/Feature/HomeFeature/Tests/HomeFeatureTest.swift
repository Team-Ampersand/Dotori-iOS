import BaseFeature
import Combine
import XCTest
@testable import HomeFeature

final class HomeFeatureTests: XCTestCase {
    var sut: HomeStore!
    var subscription: Set<AnyCancellable>!

    override func setUp() {
        sut = .init()
        subscription = .init()
    }

    override func tearDown() {
        sut = nil
        subscription = nil
    }

    func testMyInfoBarButtonDidTap() {
        let expectation = XCTestExpectation(description: "Route set to alert")
        sut.route.sink { route in
            guard case DotoriRoutePath.alert = route else {
                XCTFail("route not sent 'alert'")
                return
            }
            expectation.fulfill()
        }
        .store(in: &subscription)

        sut.send(.myInfoButtonDidTap)

        wait(for: [expectation], timeout: 1)
    }
}
