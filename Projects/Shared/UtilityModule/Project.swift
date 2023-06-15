import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.module(
    name: ModulePaths.Shared.UtilityModule.rawValue,
    targets: [
        .implements(module: .shared(.UtilityModule), product: .framework),
        .tests(module: .shared(.UtilityModule), dependencies: [
            .shared(target: .UtilityModule)
        ])
    ]
)
