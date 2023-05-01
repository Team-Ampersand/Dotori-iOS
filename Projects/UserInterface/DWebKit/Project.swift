import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: ModulePaths.UserInterface.DWebKit.rawValue,
    product: .framework,
    targets: [.unitTest, .demo],
    internalDependencies: []
)
