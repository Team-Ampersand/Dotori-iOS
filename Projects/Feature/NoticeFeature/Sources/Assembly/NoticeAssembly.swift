import ConfirmationDialogFeature
import DetailNoticeFeatureInterface
import NoticeDomainInterface
import NoticeFeatureInterface
import Swinject
import UserDomainInterface

public final class NoticeAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register(NoticeFactory.self) { resolver in
            NoticeFactoryImpl(
                fetchNoticeListUseCase: resolver.resolve(FetchNoticeListUseCase.self)!,
                loadCurrentUserRoleUseCase: resolver.resolve(LoadCurrentUserRoleUseCase.self)!,
                confirmationDialogFactory: resolver.resolve(ConfirmationDialogFactory.self)!,
                detailNoticeFactory: resolver.resolve(DetailNoticeFactory.self)!
            )
        }
    }
}
