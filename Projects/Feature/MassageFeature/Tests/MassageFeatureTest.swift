import Combine
import MassageDomainInterface
import XCTest
@testable import MassageFeature
@testable import MassageDomainTesting

final class MassageFeatureTests: XCTestCase {
    var fetchMassageRankListUseCase: FetchMassageRankListUseCaseSpy!
    var sut: MassageStore!
    var subscription: Set<AnyCancellable>!

    override func setUp() {
        fetchMassageRankListUseCase = .init()
        sut = .init(fetchMassageRankListUseCase: fetchMassageRankListUseCase)
        subscription = []
    }

    override func tearDown() {
        fetchMassageRankListUseCase = nil
        sut = nil
        subscription = nil
    }

    func testFetchMassageRankList() {
        let expectation = XCTestExpectation(description: "Test_Fetch_Massage_Rank_List")
        expectation.expectedFulfillmentCount = 2
        let expectedMassageRankList = [
            MassageRankModel(id: 1, rank: 1, stuNum: "2222", memberName: "익명", gender: .woman)
        ]
        fetchMassageRankListUseCase.fetchMassageRankListHandler = { expectedMassageRankList }

        sut.state.map(\.massageRankList).sink { _ in
            expectation.fulfill()
        }
        .store(in: &subscription)

        XCTAssertEqual(fetchMassageRankListUseCase.fetchMassageRankListCallCount, 0)

        sut.send(.fetchMassageRankList)

        wait(for: [expectation], timeout: 1.0)

        XCTAssertEqual(fetchMassageRankListUseCase.fetchMassageRankListCallCount, 1)
        XCTAssertEqual(sut.currentState.massageRankList, expectedMassageRankList)
    }
}
