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
        let expected = [NoticeEntity(id: 1, title: "title2", content: "contents", roles: .member, createdTime: date)]
        remoteNoticeDataSource.fetchNoticeListReturn = expected

        let actual = try await sut.fetchNoticeList()

        XCTAssertEqual(remoteNoticeDataSource.fetchNoticeListCallCount, 1)
        XCTAssertEqual(actual, expected)
    }

    func testFetchNotice() async throws {
        let date = Date()
        XCTAssertEqual(remoteNoticeDataSource.fetchNoticeCallCount, 0)
        let expected = DetailNoticeEntity(id: 1, title: "title2", content: "contents", role: .member, images: [], createdDate: date)
        remoteNoticeDataSource.fetchNoticeHandler = { _ in expected }

        let actual = try await sut.fetchNotice(id: 1)

        XCTAssertEqual(remoteNoticeDataSource.fetchNoticeCallCount, 1)
        XCTAssertEqual(actual, expected)
    }

    func testRemoveNotice() async throws {
        XCTAssertEqual(remoteNoticeDataSource.removeNoticeCallCount, 0)

        try await sut.removeNotice(id: 1)

        XCTAssertEqual(remoteNoticeDataSource.removeNoticeCallCount, 1)
    }
}
