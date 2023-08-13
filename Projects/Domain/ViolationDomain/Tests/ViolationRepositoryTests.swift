@testable import ViolationDomain
import ViolationDomainInterface
@testable import ViolationDomainTesting
import XCTest

final class ViolationRepositoryTests: XCTestCase {
    var remoteViolationDataSource: RemoteViolationDataSourceSpy!
    var sut: ViolationRepositoryImpl!

    override func setUp() {
        remoteViolationDataSource = .init()
        sut = .init(remoteViolationDataSource: remoteViolationDataSource)
    }

    override func tearDown() {
        remoteViolationDataSource = nil
        sut = nil
    }

    func test_FetchMyViolationList() async throws {
        let expected: [ViolationEntity] = [
            ViolationEntity(id: 1, rule: "기숙사 탈주", createDate: .init())
        ]
        remoteViolationDataSource.fetchMyViolationListHandler = { expected }
        XCTAssertEqual(remoteViolationDataSource.fetchMyViolationListCallCount, 0)

        let actual = try await sut.fetchMyViolationList()

        XCTAssertEqual(remoteViolationDataSource.fetchMyViolationListCallCount, 1)
        XCTAssertEqual(actual, expected)
    }
}
