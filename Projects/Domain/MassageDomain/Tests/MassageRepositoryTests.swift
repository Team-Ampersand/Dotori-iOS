import MassageDomainInterface
import XCTest
@testable import MassageDomain
@testable import MassageDomainTesting

final class MassageRepositoryTests: XCTestCase {
    var remoteMassageDataSource: RemoteMassageDataSourceSpy!
    var sut: MassageRepositoryImpl!

    override func setUp() {
        remoteMassageDataSource = .init()
        sut = .init(remoteMassageDataSource: remoteMassageDataSource)
    }

    override func tearDown() {
        remoteMassageDataSource = nil
        sut = nil
    }

    func testFetchMassageInfo() async throws {
        let expected = MassageInfoModel(count: 10, limit: 50, massageStatus: .can)
        remoteMassageDataSource.fetchMassageInfoReturn = expected

        let actual = try await sut.fetchMassageInfo()

        XCTAssertEqual(remoteMassageDataSource.fetchMassageInfoCallCount, 1)
        XCTAssertEqual(actual, expected)
    }
}
