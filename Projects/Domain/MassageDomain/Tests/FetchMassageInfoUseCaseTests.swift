import MassageDomainInterface
import XCTest
@testable import MassageDomain

final class FetchMassageInfoUseCaseTests: XCTestCase {
    var massageRepository: MassageRepositorySpy!
    var sut: FetchMassageInfoUseCaseImpl!

    override func setUp() {
        massageRepository = .init()
        sut = .init(massageRepository: massageRepository)
    }

    override func tearDown() {
        massageRepository = nil
        sut = nil
    }

    func testFetchMassageInfo() async throws {
        let expected = MassageInfoModel(count: 10, limit: 50, massageStatus: .can)
        massageRepository.fetchMassageInfoReturn = expected

        let actual = try await sut()

        XCTAssertEqual(massageRepository.fetchMassageInfoCallCount, 1)
        XCTAssertEqual(actual, expected)
    }
}
