import Moordinator
import UIKit

public protocol SigninFactory {
    func makeMoordinator() -> Moordinator
}
