import Foundation
import UIKit

public protocol BoundsProviable {
    var bounds: CGRect { get }
}

public extension BoundsProviable where Self: UIViewController {
    var bounds: CGRect {
        screenBounds()
    }

    private func screenBounds() -> CGRect {
        var parent = self.parent
        var lastParent = parent

        while parent != nil {
            lastParent = parent
            parent = parent?.parent
        }

        guard let bounds = lastParent?.view.window?.windowScene?.screen.bounds else {
            return .init()
        }
        return bounds
    }
}
