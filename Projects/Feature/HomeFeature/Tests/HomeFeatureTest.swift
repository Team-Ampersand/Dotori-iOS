import BaseFeature
import Combine
import XCTest
@testable import HomeFeature

final class HomeFeatureTests: XCTestCase {
    var store: HomeStore!
    var subscription: Set<AnyCancellable> = []

    override func setUp() {
        store = .init()
    }

    override func tearDown() {}

    func testMyInfoBarButtonDidTap() {
        let expectation = XCTestExpectation(description: "Route set to alert")
        store.route.sink { route in
            guard case DotoriRoutePath.alert = route else {
                XCTFail("route not sent 'alert'")
                return
            }
            expectation.fulfill()
        }
        .store(in: &subscription)

        store.send(.myInfoButtonDidTap)

        wait(for: [expectation], timeout: 1)
    }
}
