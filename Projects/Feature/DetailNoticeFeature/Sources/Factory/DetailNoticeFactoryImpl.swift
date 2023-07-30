import BaseFeature
import NoticeDomainInterface
import UIKit
import UserDomainInterface

struct DetailNoticeFactoryImpl: DetailNoticeFactory {
    private let fetchNoticeUseCase: any FetchNoticeUseCase
    private let removeNoticeUseCase: any RemoveNoticeUseCase
    private let loadCurrentUserRoleUseCase: any LoadCurrentUserRoleUseCase

    init(
        fetchNoticeUseCase: any FetchNoticeUseCase,
        removeNoticeUseCase: any RemoveNoticeUseCase,
        loadCurrentUserRoleUseCase: any LoadCurrentUserRoleUseCase
    ) {
        self.fetchNoticeUseCase = fetchNoticeUseCase
        self.removeNoticeUseCase = removeNoticeUseCase
        self.loadCurrentUserRoleUseCase = loadCurrentUserRoleUseCase
    }

    func makeViewController(noticeID: Int) -> any StoredViewControllable {
        let store = DetailNoticeStore(
            noticeID: noticeID,
            fetchNoticeUseCase: fetchNoticeUseCase,
            removeNoticeUseCase: removeNoticeUseCase,
            loadCurrentUserRoleUseCase: loadCurrentUserRoleUseCase
        )
        return DetailNoticeViewController(store: store)
    }
}
