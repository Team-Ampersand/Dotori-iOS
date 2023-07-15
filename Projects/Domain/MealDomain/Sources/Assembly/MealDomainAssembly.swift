import AsyncNeiSwift
import DatabaseInterface
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

        container.register(LocalMealDataSource.self) { resolver in
            LocalMealDataSourceImpl(database: resolver.resolve(LocalDatabase.self)!)
        }

        container.register(MealRepository.self) { resolver in
            MealRepositoryImpl(
                remoteMealDataSource: resolver.resolve(RemoteMealDataSource.self)!,
                localMealDataSource: resolver.resolve(LocalMealDataSource.self)!
            )
        }
        .inObjectScope(.container)

        container.register(FetchMealInfoUseCase.self) { resolver in
            FetchMealInfoUseCaseImpl(mealRepository: resolver.resolve(MealRepository.self)!)
        }
        .inObjectScope(.container)
    }
}
