import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: ModulePaths.Feature.MassageFeature.rawValue,
    product: .staticLibrary,
    targets: [.unitTest],
    internalDependencies: []
)
