import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: ModulePaths.Feature.NoticeFeature.rawValue,
    product: .staticLibrary,
    targets: [.unitTest],
    internalDependencies: []
)
