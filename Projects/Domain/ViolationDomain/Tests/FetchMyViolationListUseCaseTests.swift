import ViolationDomainInterface
import XCTest
@testable import ViolationDomain
@testable import ViolationDomainTesting

final class FetchMyViolationListUseCaseTests: XCTestCase {
    var violationRepository: ViolationRepositorySpy!
    var sut: FetchMyViolationListUseCaseImpl!

    override func setUp() {
        violationRepository = .init()
        sut = .init(violationRepository: violationRepository)
    }

    override func tearDown() {
        violationRepository = nil
        sut = nil
    }

    func test_FetchMyViolationList() async throws {
        let expected: [ViolationModel] = [
            ViolationModel(id: 1, rule: "기숙사 탈주", createDate: .init())
        ]
        violationRepository.fetchMyViolationListHandler = { expected }
        XCTAssertEqual(violationRepository.fetchMyViolationListCallCount, 0)

        let actual = try await sut()

        XCTAssertEqual(violationRepository.fetchMyViolationListCallCount, 1)
        XCTAssertEqual(actual, expected)
    }
}
