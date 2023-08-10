import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Shared.UtilityModule.rawValue,
    targets: [
        .implements(module: .shared(.UtilityModule), product: .framework),
        .tests(module: .shared(.UtilityModule), dependencies: [
            .shared(target: .UtilityModule)
        ])
    ]
)
