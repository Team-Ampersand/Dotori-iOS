import BaseDomainInterface
import UserDomainInterface

final class LoadCurrentUserRoleUseCaseSpy: LoadCurrentUserRoleUseCase {
    var loadCurrentUserRoleCallCount = 0
    var loadCurrentUserRoleReturn: UserRoleType = .member
    func callAsFunction() throws -> UserRoleType {
        loadCurrentUserRoleCallCount += 1
        return loadCurrentUserRoleReturn
    }
}
