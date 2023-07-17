import MassageDomainInterface
import XCTest
@testable import MassageDomain
@testable import MassageDomainTesting

final class ApplyMassageUseCaseTests: XCTestCase {
    var massageRepository: MassageRepositorySpy!
    var sut: ApplyMassageUseCaseImpl!

    override func setUp() {
        massageRepository = .init()
        sut = .init(massageRepository: massageRepository)
    }

    override func tearDown() {
        massageRepository = nil
        sut = nil
    }

    func testApplyMassage() async throws {
        XCTAssertEqual(massageRepository.applyMassageCallCount, 0)
        try await sut()

        XCTAssertEqual(massageRepository.fetchMassageInfoCallCount, 1)
    }
}
