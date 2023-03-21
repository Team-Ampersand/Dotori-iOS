import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: ModulePaths.Shared.Then.rawValue,
    product: .staticLibrary,
    targets: [.unitTest],
    internalDependencies: []
)
