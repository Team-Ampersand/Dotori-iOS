import ConfirmationDialogFeatureInterface
import DetailNoticeFeatureInterface
import Moordinator
import NoticeDomainInterface
import NoticeFeatureInterface
import UserDomainInterface

struct NoticeFactoryImpl: NoticeFactory {
    private let fetchNoticeListUseCase: any FetchNoticeListUseCase
    private let loadCurrentUserRoleUseCase: any LoadCurrentUserRoleUseCase
    private let confirmationDialogFactory: any ConfirmationDialogFactory
    private let detailNoticeFactory: any DetailNoticeFactory

    init(
        fetchNoticeListUseCase: any FetchNoticeListUseCase,
        loadCurrentUserRoleUseCase: any LoadCurrentUserRoleUseCase,
        confirmationDialogFactory: any ConfirmationDialogFactory,
        detailNoticeFactory: any DetailNoticeFactory
    ) {
        self.fetchNoticeListUseCase = fetchNoticeListUseCase
        self.loadCurrentUserRoleUseCase = loadCurrentUserRoleUseCase
        self.confirmationDialogFactory = confirmationDialogFactory
        self.detailNoticeFactory = detailNoticeFactory
    }

    func makeMoordinator() -> Moordinator {
        let noticeStore = NoticeStore(
            fetchNoticeListUseCase: fetchNoticeListUseCase,
            loadCurrentUserRoleUseCase: loadCurrentUserRoleUseCase
        )
        let noticeViewController = NoticeViewController(store: noticeStore)
        return NoticeMoordinator(
            noticeViewController: noticeViewController,
            confirmationDialogFactory: confirmationDialogFactory,
            detailNoticeFactory: detailNoticeFactory
        )
    }
}
