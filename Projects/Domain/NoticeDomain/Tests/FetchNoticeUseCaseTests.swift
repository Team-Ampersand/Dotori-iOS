@testable import NoticeDomain
import NoticeDomainInterface
@testable import NoticeDomainTesting
import XCTest

final class FetchNoticeUseCaseTests: XCTestCase {
    var noticeRepository: NoticeRepositorySpy!
    var sut: FetchNoticeUseCaseImpl!

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
        XCTAssertEqual(noticeRepository.fetchNoticeCallCount, 0)
        let expected = DetailNoticeEntity(
            id: 1,
            title: "b",
            content: "aj",
            role: .councillor,
            images: [],
            createdDate: .init(),
            modifiedDate: nil
        )
        noticeRepository.fetchNoticeHandler = { _ in expected }

        let actual = try await sut(id: 1)

        XCTAssertEqual(noticeRepository.fetchNoticeCallCount, 1)
        XCTAssertEqual(actual, expected)
    }
}
