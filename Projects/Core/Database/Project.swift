import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.module(
    name: ModulePaths.Core.Database.rawValue,
    targets: [
        .interface(module: .core(.Database), dependencies: [
            .SPM.GRDB
        ]),
        .implements(module: .core(.Database), dependencies: [
            .core(target: .Database, type: .interface),
        ]),
        .testing(module: .core(.Database), dependencies: [
            .core(target: .Database, type: .interface)
        ]),
        .tests(module: .core(.Database), dependencies: [
            .core(target: .Database)
        ])
    ]
)
