import Combine
import UIKit

public extension UIStepper {
    var valuePublisher: AnyPublisher<Double, Never> {
        controlPublisher(for: .valueChanged)
            .compactMap { $0 as? UIStepper }
            .map(\.value)
            .eraseToAnyPublisher()
    }
}
