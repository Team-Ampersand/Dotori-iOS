public typealias IsLoggedIn = Bool

public protocol CheckIsLoggedInUseCase {
    func callAsFunction() async -> IsLoggedIn
}
