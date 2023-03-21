import Combine
import UIKit

public extension UITextField {
    var textPublisher: AnyPublisher<String, Never> {
        controlPublisher(for: .editingChanged)
            .compactMap { $0 as? UITextField }
            .compactMap(\.text)
            .eraseToAnyPublisher()
    }
}
