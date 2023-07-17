import SelfStudyDomainInterface
import XCTest
@testable import SelfStudyDomainTesting
@testable import SelfStudyDomain

final class ApplySelfStudyUseCaseTests: XCTestCase {
    var selfStudyRepository: SelfStudyRepositorySpy!
    var sut: ApplySelfStudyUseCaseImpl!

    override func setUp() {
        selfStudyRepository = .init()
        sut = .init(selfStudyRepository: selfStudyRepository)
    }

    override func tearDown() {
        selfStudyRepository = nil
        sut = nil
    }

    func testFetchSelfStudyInfo() async throws {
        XCTAssertEqual(selfStudyRepository.applySelfStudyCallCount, 0)
        try await sut()

        XCTAssertEqual(selfStudyRepository.applySelfStudyCallCount, 1)
    }
}
