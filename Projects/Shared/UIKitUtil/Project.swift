import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: ModulePaths.Shared.UIKitUtil.rawValue,
    product: .staticLibrary,
    targets: [.unitTest],
    internalDependencies: []
)
