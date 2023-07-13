import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.module(
    name: ModulePaths.Core.Timer.rawValue,
    targets: [
        .interface(module: .core(.Timer)),
        .implements(module: .core(.Timer), dependencies: [
            .core(target: .Timer, type: .interface),
            .shared(target: .GlobalThirdPartyLibrary)
        ]),
        .testing(module: .core(.Timer), dependencies: [
            .core(target: .Timer, type: .interface)
        ]),
        .tests(module: .core(.Timer), dependencies: [
            .core(target: .Timer)
        ])
    ]
)
