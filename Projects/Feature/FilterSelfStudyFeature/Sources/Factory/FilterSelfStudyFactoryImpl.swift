import BaseFeatureInterface
import FilterSelfStudyFeatureInterface

struct FilterSelfStudyFactoryImpl: FilterSelfStudyFactory {
    func makeViewController(
        confirmAction: @escaping (
            _ name: String?,
            _ grade: Int?,
            _ `class`: Int?,
            _ gender: String?
        ) -> Void
    ) -> any RoutedViewControllable {
        let store = FilterSelfStudyStore(confirmAction: confirmAction)
        return FilterSelfStudyViewController(store: store)
    }
}
