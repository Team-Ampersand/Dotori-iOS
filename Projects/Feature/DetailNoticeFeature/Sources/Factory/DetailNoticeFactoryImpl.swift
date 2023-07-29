import BaseFeature
import NoticeDomainInterface
import UIKit

struct DetailNoticeFactoryImpl: DetailNoticeFactory {
    private let fetchNoticeUseCase: any FetchNoticeUseCase

    init(fetchNoticeUseCase: any FetchNoticeUseCase) {
        self.fetchNoticeUseCase = fetchNoticeUseCase
    }

    func makeViewController(noticeID: Int) -> any StoredViewControllable {
        let store = DetailNoticeStore(
            noticeID: noticeID,
            fetchNoticeUseCase: fetchNoticeUseCase
        )
        return DetailNoticeViewController(store: store)
    }
}
