import BaseFeatureInterface

public protocol FilterSelfStudyFactory {
    func makeViewController(
        confirmAction: @escaping (
            _ name: String?,
            _ grade: Int?,
            _ `class`: Int?,
            _ gender: String?
        ) -> Void
    ) -> any RoutedViewControllable
}
