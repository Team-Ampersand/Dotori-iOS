import Moordinator
import UIKit

public protocol MainFactory {
    func makeMoordinator() -> Moordinator
}
