@testable import SelfStudyDomain
import SelfStudyDomainInterface
@testable import SelfStudyDomainTesting
import XCTest

final class FetchSelfStudyRankListUseCaseTests: XCTestCase {
    var selfStudyRepository: SelfStudyRepositorySpy!
    var sut: FetchSelfStudyRankListUseCaseImpl!

    override func setUp() {
        selfStudyRepository = .init()
        sut = .init(selfStudyRepository: selfStudyRepository)
    }

    override func tearDown() {
        selfStudyRepository = nil
        sut = nil
    }

    func testFetchSelfStudyRankList_When_ReqNil() async throws {
        let expected = [
            SelfStudyRankModel(id: 1, rank: 1, stuNum: "3218", memberName: "김준", gender: .man, selfStudyCheck: true)
        ]
        selfStudyRepository.fetchSelfStudyRankListReturn = expected

        let actual = try await sut()

        XCTAssertEqual(selfStudyRepository.fetchSelfStudyRankListCallCount, 1)
        XCTAssertEqual(actual, expected)
    }

    func testFetchSelfStudyRankList() async throws {
        let expected = [
            SelfStudyRankModel(id: 1, rank: 1, stuNum: "3218", memberName: "김준", gender: .man, selfStudyCheck: true)
        ]
        selfStudyRepository.fetchSelfStudyRankSearchReturn = expected

        let actual = try await sut(req: .init(name: "김"))

        XCTAssertEqual(selfStudyRepository.fetchSelfStudyRankSearchCallCount, 1)
        XCTAssertEqual(actual, expected)
    }
}
