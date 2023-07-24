import UIKit

public protocol AdaptableCell {
    associatedtype Model

    func adapt(model: Model)
}
