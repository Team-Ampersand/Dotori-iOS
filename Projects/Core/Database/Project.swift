import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Core.Database.rawValue,
    targets: [
        .interface(module: .core(.Database), dependencies: [
            .SPM.GRDB
        ]),
        .implements(module: .core(.Database), dependencies: [
            .core(target: .Database, type: .interface),
            .shared(target: .GlobalThirdPartyLibrary)
        ]),
        .testing(module: .core(.Database), dependencies: [
            .core(target: .Database, type: .interface)
        ]),
        .tests(module: .core(.Database), dependencies: [
            .core(target: .Database)
        ])
    ]
)
