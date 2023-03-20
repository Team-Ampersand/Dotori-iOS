import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: ModulePaths.Core.DWebKit.rawValue,
    product: .staticLibrary,
    targets: [.unitTest, .demo],
    internalDependencies: []
)
