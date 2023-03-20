import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: ModulePaths.Core.DWebKit.rawValue,
    product: .framework,
    targets: [.unitTest, .demo],
    internalDependencies: []
)
