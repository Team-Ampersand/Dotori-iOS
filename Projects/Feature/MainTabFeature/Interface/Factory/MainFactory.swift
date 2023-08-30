import BaseFeatureInterface
import Moordinator

public protocol MainFactory {
    func makeMoordinator() -> Moordinator
}
