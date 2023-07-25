import MassageDomainInterface
import MealDomainInterface
import Moordinator
import SelfStudyDomainInterface
import Swinject
import TimerInterface
import UserDomainInterface

public final class HomeAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register(HomeFactory.self) { resolver in
            HomeFactoryImpl(
                repeatableTimer: resolver.resolve(RepeatableTimer.self)!,
                fetchSelfStudyInfoUseCase: resolver.resolve(FetchSelfStudyInfoUseCase.self)!,
                fetchMassageInfoUseCase: resolver.resolve(FetchMassageInfoUseCase.self)!,
                fetchMealInfoUseCase: resolver.resolve(FetchMealInfoUseCase.self)!,
                loadCurrentUserRoleUseCase: resolver.resolve(LoadCurrentUserRoleUseCase.self)!,
                applySelfStudyUseCase: resolver.resolve(ApplySelfStudyUseCase.self)!,
                cancelSelfStudyUseCase: resolver.resolve(CancelSelfStudyUseCase.self)!,
                applyMassageUseCase: resolver.resolve(ApplyMassageUseCase.self)!,
                cancelMassageUseCase: resolver.resolve(CancelMassageUseCase.self)!
            )
        }
    }
}
