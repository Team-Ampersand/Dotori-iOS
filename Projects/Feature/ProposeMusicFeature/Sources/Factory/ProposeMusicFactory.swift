import BaseFeature
import UIKit

public protocol ProposeMusicFactory {
    func makeViewController() -> any StoredViewControllable
}
