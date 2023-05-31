import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: ModulePaths.Feature.SelfStudyFeature.rawValue,
    product: .staticLibrary,
    targets: [.unitTest],
    internalDependencies: []
)
