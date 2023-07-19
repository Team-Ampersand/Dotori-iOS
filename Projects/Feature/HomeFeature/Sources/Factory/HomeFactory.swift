import Moordinator
import UIKit

public protocol HomeFactory {
    func makeMoordinator() -> Moordinator
}
