import XCTest
@testable import DetailNoticeFeature
@testable import NoticeDomainTesting
@testable import UserDomainTesting

final class DetailNoticeFeatureTests: XCTestCase {
    var fetchNoticeUseCase: FetchNoticeUseCaseSpy!
    var removeNoticeUseCase: RemoveNoticeUseCaseSpy!
    var loadCurrentUserRoleUseCase: LoadCurrentUserRoleUseCaseSpy!
    var sut: DetailNoticeStore!

    override func setUp() {
        fetchNoticeUseCase = .init()
        removeNoticeUseCase = .init()
        loadCurrentUserRoleUseCase = .init()
        sut = .init(
            noticeID: 1,
            fetchNoticeUseCase: fetchNoticeUseCase,
            removeNoticeUseCase: removeNoticeUseCase,
            loadCurrentUserRoleUseCase: loadCurrentUserRoleUseCase
        )
    }

    override func tearDown() {
        fetchNoticeUseCase = nil
        removeNoticeUseCase = nil
        loadCurrentUserRoleUseCase = nil
        sut = nil
    }
}
