import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Core.KeyValueStore.rawValue,
    targets: [
        .interface(module: .core(.KeyValueStore)),
        .implements(module: .core(.KeyValueStore), dependencies: [
            .core(target: .KeyValueStore, type: .interface),
            .shared(target: .GlobalThirdPartyLibrary)
        ]),
        .testing(module: .core(.KeyValueStore), dependencies: [
            .core(target: .KeyValueStore, type: .interface)
        ]),
        .tests(module: .core(.KeyValueStore), dependencies: [
            .core(target: .KeyValueStore)
        ])
    ]
)
