import NoticeDomainInterface
import XCTest
@testable import NoticeDomain
@testable import NoticeDomainTesting

final class RemoveNoticeUseCaseTests: XCTestCase {
    var noticeRepository: NoticeRepositorySpy!
    var sut: RemoveNoticeUseCaseImpl!

    override func setUp() {
        noticeRepository = .init()
        sut = .init(noticeRepository: noticeRepository)
    }

    override func tearDown() {
        noticeRepository = nil
        sut = nil
    }

    func testCallAsFunction() async throws {
        XCTAssertEqual(noticeRepository.removeNoticeCallCount, 0)

        try await sut(id: 1)

        XCTAssertEqual(noticeRepository.removeNoticeCallCount, 1)
    }
}
