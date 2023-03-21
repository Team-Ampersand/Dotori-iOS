import Combine
import UIKit

public extension UISwitch {
    var valuePublisher: AnyPublisher<Bool, Never> {
        controlPublisher(for: .valueChanged)
            .compactMap { $0 as? UISwitch }
            .map(\.isOn)
            .eraseToAnyPublisher()
    }
}
