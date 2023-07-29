import BaseFeature
import NoticeDomainInterface
import UIKit
import UserDomainInterface

struct DetailNoticeFactoryImpl: DetailNoticeFactory {
    private let fetchNoticeUseCase: any FetchNoticeUseCase
    private let loadCurrentUserRole: any LoadCurrentUserRoleUseCase

    init(
        fetchNoticeUseCase: any FetchNoticeUseCase,
        loadCurrentUserRole: any LoadCurrentUserRoleUseCase
    ) {
        self.fetchNoticeUseCase = fetchNoticeUseCase
        self.loadCurrentUserRole = loadCurrentUserRole
    }

    func makeViewController(noticeID: Int) -> any StoredViewControllable {
        let store = DetailNoticeStore(
            noticeID: noticeID,
            fetchNoticeUseCase: fetchNoticeUseCase,
            loadCurrentUserRole: loadCurrentUserRole
        )
        return DetailNoticeViewController(store: store)
    }
}
