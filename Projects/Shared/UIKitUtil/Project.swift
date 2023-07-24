import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Shared.UIKitUtil.rawValue,
    targets: [
        .implements(module: .shared(.UIKitUtil), product: .framework)
    ]
)
