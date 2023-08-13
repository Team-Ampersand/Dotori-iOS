import Combine
@testable import MyViolationListFeature
import ViolationDomainInterface
@testable import ViolationDomainTesting
import XCTest

final class MyViolationHistoryFeatureTests: XCTestCase {
    var fetchMyViolationListUseCase: FetchMyViolationListUseCaseSpy!
    var sut: MyViolationListStore!
    var subscription: Set<AnyCancellable>!

    override func setUp() {
        fetchMyViolationListUseCase = .init()
        sut = .init(fetchMyViolationListUseCase: fetchMyViolationListUseCase)
        subscription = .init()
    }

    override func tearDown() {
        fetchMyViolationListUseCase = nil
        sut = nil
        subscription = nil
    }

    func testFetchMyViolationList_Store_State() {
        let expectation = XCTestExpectation(description: "testFetchMyViolationList_Store_State")
        expectation.expectedFulfillmentCount = 2
        let expected: [ViolationModel] = [
            .init(id: 1, rule: "긱사 탈주", createDate: .init())
        ]
        fetchMyViolationListUseCase.fetchMyViolationListHandler = { expected }

        sut.state.map(\.violationList).sink { _ in
            expectation.fulfill()
        }
        .store(in: &subscription)

        XCTAssertEqual(fetchMyViolationListUseCase.fetchMyViolationListCallCount, 0)

        sut.send(.fetchMyViolationList)

        wait(for: [expectation], timeout: 1)

        XCTAssertEqual(fetchMyViolationListUseCase.fetchMyViolationListCallCount, 1)
        XCTAssertEqual(sut.currentState.violationList, expected)
    }
}
