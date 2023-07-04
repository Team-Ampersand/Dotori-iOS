import KeyValueStoreInterface
import Swinject
import UserDomainInterface

public final class UserDomainAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register(LocalUserDataSource.self) { resolver in
            LocalUserDataSourceImpl(keyValueStore: resolver.resolve(KeyValueStore.self)!)
        }
        .inObjectScope(.container)

        container.register(UserRepository.self) { resolver in
            UserRepositoryImpl(localUserDataSource: resolver.resolve(LocalUserDataSource.self)!)
        }
        .inObjectScope(.container)

        container.register(LoadCurrentUserRoleUseCase.self) { resolver in
            LoadCurrentUserRoleUseCaseImpl(userRepository: resolver.resolve(UserRepository.self)!)
        }
    }
}
