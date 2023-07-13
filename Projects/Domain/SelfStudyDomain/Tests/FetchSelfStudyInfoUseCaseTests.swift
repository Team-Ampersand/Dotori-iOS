import SelfStudyDomainInterface
import XCTest
@testable import SelfStudyDomainTesting
@testable import SelfStudyDomain

final class FetchSelfStudyInfoUseCaseTests: XCTestCase {
    var selfStudyRepository: SelfStudyRepositorySpy!
    var sut: FetchSelfStudyInfoUseCaseImpl!

    override func setUp() {
        selfStudyRepository = .init()
        sut = .init(selfStudyRepository: selfStudyRepository)
    }

    override func tearDown() {
        selfStudyRepository = nil
        sut = nil
    }

    func testFetchSelfStudyInfo() async throws {
        let expected = SelfStudyInfoModel(count: 10, limit: 50, selfStudyStatus: .can)
        selfStudyRepository.fetchSelfStudyInfoReturn = expected

        let actual = try await sut()

        XCTAssertEqual(selfStudyRepository.fetchSelfStudyInfoCallCount, 1)
        XCTAssertEqual(actual, expected)
    }
}
