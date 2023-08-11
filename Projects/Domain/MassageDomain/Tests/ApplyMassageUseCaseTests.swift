@testable import MassageDomain
import MassageDomainInterface
@testable import MassageDomainTesting
import XCTest

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

        XCTAssertEqual(massageRepository.applyMassageCallCount, 1)
    }
}
