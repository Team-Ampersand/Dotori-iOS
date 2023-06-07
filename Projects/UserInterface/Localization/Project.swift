import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: ModulePaths.UserInterface.Localization.rawValue,
    product: .staticLibrary,
    targets: [],
    internalDependencies: []
)
