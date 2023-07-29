import XCTest
@testable import DetailNoticeFeature
@testable import NoticeDomainTesting
@testable import UserDomainTesting

final class DetailNoticeFeatureTests: XCTestCase {
    var fetchNoticeUseCase: FetchNoticeUseCaseSpy!
    var loadCurrentUserRoleUseCase: LoadCurrentUserRoleUseCaseSpy!
    var sut: DetailNoticeStore!

    override func setUp() {
        fetchNoticeUseCase = .init()
        loadCurrentUserRoleUseCase = .init()
        sut = .init(
            noticeID: 1,
            fetchNoticeUseCase: fetchNoticeUseCase,
            loadCurrentUserRole: loadCurrentUserRoleUseCase
        )
    }

    override func tearDown() {
        fetchNoticeUseCase = nil
        loadCurrentUserRoleUseCase = nil
        sut = nil
    }
}
