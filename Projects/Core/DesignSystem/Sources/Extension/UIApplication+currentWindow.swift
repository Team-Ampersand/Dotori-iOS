import UIKit

public extension UIApplication {
    static func currentWindow() -> UIWindow? {
        return shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }
     }
}
