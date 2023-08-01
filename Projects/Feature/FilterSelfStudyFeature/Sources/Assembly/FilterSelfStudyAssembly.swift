import FilterSelfStudyFeatureInterface
import Swinject

public final class FilterSelfStudyAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register(FilterSelfStudyFactory.self) { _ in
            FilterSelfStudyFactoryImpl()
        }
    }
}
