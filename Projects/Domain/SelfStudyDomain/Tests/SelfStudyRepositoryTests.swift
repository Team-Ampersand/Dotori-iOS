import SelfStudyDomainInterface
import XCTest
@testable import SelfStudyDomain
@testable import SelfStudyDomainTesting

final class SelfStudyRepositoryTests: XCTestCase {
    var remoteSelfStudyDataSource: RemoteSelfStudyDataSourceSpy!
    var sut: SelfStudyRepositoryImpl!

    override func setUp() {
        remoteSelfStudyDataSource = .init()
        sut = .init(remoteSelfStudyDataSource: remoteSelfStudyDataSource)
    }

    override func tearDown() {
        remoteSelfStudyDataSource = nil
        sut = nil
    }

    func testFetchSelfStudyInfo() async throws {
        XCTAssertEqual(remoteSelfStudyDataSource.fetchSelfStudyInfoCallCount, 0)
        let expected = SelfStudyInfoEntity(count: 10, limit: 50, selfStudyStatus: .can)
        remoteSelfStudyDataSource.fetchSelfStudyInfoReturn = expected

        let actual = try await sut.fetchSelfStudyInfo()

        XCTAssertEqual(remoteSelfStudyDataSource.fetchSelfStudyInfoCallCount, 1)
        XCTAssertEqual(actual, expected)
    }

    func applySelfStudy() async throws {
        XCTAssertEqual(remoteSelfStudyDataSource.applySelfStudyCallCount, 0)
        try await sut.applySelfStudy()

        XCTAssertEqual(remoteSelfStudyDataSource.applySelfStudyCallCount, 1)
    }
}
