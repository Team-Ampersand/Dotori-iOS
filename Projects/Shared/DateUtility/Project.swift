import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Shared.DateUtility.rawValue,
    targets: [
        .implements(module: .shared(.DateUtility)),
        .tests(module: .shared(.DateUtility), dependencies: [
            .shared(target: .DateUtility)
        ])
    ]
)
