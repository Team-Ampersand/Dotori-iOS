import Moordinator

public protocol HomeFactory {
    func makeMoordinator() -> Moordinator
}
