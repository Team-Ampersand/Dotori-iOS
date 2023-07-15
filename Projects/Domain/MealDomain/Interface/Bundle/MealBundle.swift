import Foundation

private class MealBundleFinder {}

public extension Foundation.Bundle {
    static let meal = Bundle(for: MealBundleFinder.self)
}
