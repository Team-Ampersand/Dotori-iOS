import BaseDomainInterface
@testable import NoticeDomain
import NoticeDomainInterface
@testable import NoticeDomainTesting
import XCTest

final class FetchNoticeListUseCaseTests: XCTestCase {
    var noticeRepository: NoticeRepositorySpy!
    var sut: FetchNoticeListUseCaseImpl!

    override func setUp() {
        noticeRepository = .init()
        sut = .init(noticeRepository: noticeRepository)
    }

    override func tearDown() {
        noticeRepository = nil
        sut = nil
    }

    func testCallAsFunction() async throws {
        let date = Date()
        XCTAssertEqual(noticeRepository.fetchNoticeListCallCount, 0)
        let expected = [NoticeModel(id: 1, title: "tit", content: "con", roles: .councillor, createdTime: date)]
        noticeRepository.fetchNoticeListReturn = expected

        let actual = try await sut()

        XCTAssertEqual(noticeRepository.fetchNoticeListCallCount, 1)
        XCTAssertEqual(actual, expected)
    }
}
