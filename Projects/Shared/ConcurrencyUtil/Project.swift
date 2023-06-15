import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.module(
    name: ModulePaths.Shared.ConcurrencyUtil.rawValue,
    targets: [
        .implements(module: .shared(.ConcurrencyUtil)),
        .tests(module: .shared(.ConcurrencyUtil), dependencies: [
            .shared(target: .ConcurrencyUtil)
        ])
    ]
)
