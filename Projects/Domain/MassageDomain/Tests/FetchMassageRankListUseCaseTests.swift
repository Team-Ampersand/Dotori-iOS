import MassageDomainInterface
import XCTest
@testable import MassageDomain
@testable import MassageDomainTesting

final class FetchMassageRankListUseCaseTests: XCTestCase {
    var massageRepository: MassageRepositorySpy!
    var sut: FetchMassageRankListUseCaseImpl!

    override func setUp() {
        massageRepository = .init()
        sut = .init(massageRepository: massageRepository)
    }

    override func tearDown() {
        massageRepository = nil
        sut = nil
    }

    func testFetchMassageInfo() async throws {
        XCTAssertEqual(massageRepository.fetchMassageRankListCallCount, 0)
        let expected = [
            MassageRankModel(id: 1, rank: 2, stuNum: "1111", memberName: "김시훈", gender: .man)
        ]
        massageRepository.fetchMassageRankListHandler = { expected }

        let actual = try await sut()

        XCTAssertEqual(massageRepository.fetchMassageRankListCallCount, 1)
        XCTAssertEqual(actual, expected)
    }
}
