import BaseFeatureInterface
import Moordinator

public protocol MassageFactory {
    func makeMoordinator() -> Moordinator
}
