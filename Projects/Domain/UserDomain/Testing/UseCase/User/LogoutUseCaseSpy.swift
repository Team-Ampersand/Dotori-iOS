import UserDomainInterface

final class LogoutUseCaseSpy: LogoutUseCase {
    var logoutCallCount = 0
    func callAsFunction() {
        logoutCallCount += 1
    }
}
