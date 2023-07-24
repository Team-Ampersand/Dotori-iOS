import AuthDomainInterface

final class CheckIsLoggedInUseCaseSpy: CheckIsLoggedInUseCase {
    var checkIsLoggedInCallCount = 0
    var checkIsLoggedInReturn = true
    func callAsFunction() async -> IsLoggedIn {
        checkIsLoggedInCallCount += 1
        return checkIsLoggedInReturn
    }
}
