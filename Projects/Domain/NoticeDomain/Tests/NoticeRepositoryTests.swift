import BaseDomainInterface
import NoticeDomainInterface
import XCTest
@testable import NoticeDomain
@testable import NoticeDomainTesting

final class NoticeRepositoryTests: XCTestCase {
    var remoteNoticeDataSource: RemoteNoticeDataSourceSpy!
    var sut: NoticeRepositoryImpl!

    override func setUp() {
        remoteNoticeDataSource = .init()
        sut = .init(remoteNoticeDataSource: remoteNoticeDataSource)
    }

    override func tearDown() {
        remoteNoticeDataSource = nil
        sut = nil
    }

    func testFetchNoticeList() async throws {
        let date = Date()
        XCTAssertEqual(remoteNoticeDataSource.fetchNoticeListCallCount, 0)
        let expected = [NoticeModel(id: 1, title: "title2", content: "contents", roles: .member, createdTime: date)]
        remoteNoticeDataSource.fetchNoticeListReturn = expected

        let actual = try await sut.fetchNoticeList()

        XCTAssertEqual(remoteNoticeDataSource.fetchNoticeListCallCount, 1)
        XCTAssertEqual(actual, expected)
    }
}
