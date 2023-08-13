import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Shared.ConcurrencyUtil.rawValue,
    targets: [
        .implements(module: .shared(.ConcurrencyUtil)),
        .tests(module: .shared(.ConcurrencyUtil), dependencies: [
            .shared(target: .ConcurrencyUtil)
        ])
    ]
)
