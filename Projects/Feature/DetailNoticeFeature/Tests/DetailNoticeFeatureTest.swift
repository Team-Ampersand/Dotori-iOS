import XCTest
@testable import DetailNoticeFeature
@testable import NoticeDomainTesting

final class DetailNoticeFeatureTests: XCTestCase {
    var fetchNoticeUseCase: FetchNoticeUseCaseSpy!
    var sut: DetailNoticeStore!

    override func setUp() {
        fetchNoticeUseCase = .init()
        sut = .init(fetchNoticeUseCase: fetchNoticeUseCase)
    }

    override func tearDown() {
        fetchNoticeUseCase = nil
        sut = nil
    }
}
