import AsyncNeiSwift
import MealDomainInterface
import NeiSwift
import Swinject

public final class MealDomainAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register(AsyncNeisProtocol.self) { _ in
            Neis()
        }

        container.register(RemoteMealDataSource.self) { resolver in
            RemoteMealDataSourceImpl(neis: resolver.resolve(AsyncNeisProtocol.self)!)
        }
        .inObjectScope(.container)

        container.register(MealRepository.self) { resolver in
            MealRepositoryImpl(remoteMealDataSource: resolver.resolve(RemoteMealDataSource.self)!)
        }
        .inObjectScope(.container)

        container.register(FetchMealInfoUseCase.self) { resolver in
            FetchMealInfoUseCaseImpl(mealRepository: resolver.resolve(MealRepository.self)!)
        }
        .inObjectScope(.container)
    }
}
