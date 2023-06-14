import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.module(
    name: ModulePaths.Shared.CombineUtility.rawValue,
    targets: [
        .implements(module: .shared(.CombineUtility)),
        .tests(module: .shared(.CombineUtility), dependencies: [
            .shared(.CombineUtility)
        ])
    ]
)
