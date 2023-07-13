import SelfStudyDomainInterface
import XCTest
@testable import SelfStudyDomain

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
        let expected = SelfStudyInfoEntity(count: 10, limit: 50, selfStudyStatus: .can)
        remoteSelfStudyDataSource.fetchSelfStudyInfoReturn = expected

        let actual = try await sut.fetchSelfStudyInfo()

        XCTAssertEqual(remoteSelfStudyDataSource.fetchSelfStudyInfoCallCount, 1)
        XCTAssertEqual(actual, expected)
    }
}
