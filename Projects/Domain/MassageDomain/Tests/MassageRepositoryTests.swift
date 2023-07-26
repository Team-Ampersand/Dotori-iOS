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
        XCTAssertEqual(remoteMassageDataSource.fetchMassageInfoCallCount, 0)
        let expected = MassageInfoEntity(count: 10, limit: 50, massageStatus: .can)
        remoteMassageDataSource.fetchMassageInfoReturn = expected

        let actual = try await sut.fetchMassageInfo()

        XCTAssertEqual(remoteMassageDataSource.fetchMassageInfoCallCount, 1)
        XCTAssertEqual(actual, expected)
    }

    func testApplyMassage() async throws {
        XCTAssertEqual(remoteMassageDataSource.applyMassageCallCount, 0)
        try await sut.applyMassage()

        XCTAssertEqual(remoteMassageDataSource.applyMassageCallCount, 1)
    }

    func testCancelMassage() async throws {
        XCTAssertEqual(remoteMassageDataSource.cancelMassageCallCount, 0)
        try await sut.cancelMassage()

        XCTAssertEqual(remoteMassageDataSource.cancelMassageCallCount, 1)
    }

    func testFetchMassageRankList() async throws {
        XCTAssertEqual(remoteMassageDataSource.fetchMassageRankListCallCount, 0)
        let expected = [
            MassageRankModel(id: 1, rank: 2, stuNum: "3218", memberName: "전승원", gender: .man)
        ]
        remoteMassageDataSource.fetchMassageRankListHandler = { expected }

        let actual = try await sut.fetchMassageRankList()

        XCTAssertEqual(remoteMassageDataSource.fetchMassageRankListCallCount, 1)
        XCTAssertEqual(actual, expected)
    }
}
