import Moordinator

public protocol SigninFactory {
    func makeMoordinator() -> Moordinator
}
