import Combine
import XCTest
@testable import NoticeFeature
@testable import NoticeDomainTesting
@testable import UserDomainTesting

final class NoticeFeatureTests: XCTestCase {
    var fetchNoticeListUseCase: FetchNoticeListUseCaseSpy!
    var loadCurrentUserRoleUseCase: LoadCurrentUserRoleUseCaseSpy!
    var sut: NoticeStore!
    var subscription: Set<AnyCancellable>!

    override func setUp() {
        fetchNoticeListUseCase = .init()
        loadCurrentUserRoleUseCase = .init()
        sut = .init(
            fetchNoticeListUseCase: fetchNoticeListUseCase,
            loadCurrentUserRoleUseCase: loadCurrentUserRoleUseCase
        )
        subscription = .init()
    }

    override func tearDown() {
        fetchNoticeListUseCase = nil
        loadCurrentUserRoleUseCase = nil
        sut = nil
        subscription = nil
    }

    func testViewDidLoad() {
        XCTAssertEqual(1, 1)
    }
}
