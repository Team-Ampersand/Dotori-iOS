import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.module(
    name: ModulePaths.Domain.MassageDomain.rawValue,
    targets: [
        .interface(module: .domain(.MassageDomain)),
        .implements(module: .domain(.MassageDomain), dependencies: [
            .domain(target: .MassageDomain, type: .interface),
            .domain(target: .BaseDomain)
        ]),
        .testing(module: .domain(.MassageDomain), dependencies: [
            .domain(target: .MassageDomain, type: .interface)
        ]),
        .tests(module: .domain(.MassageDomain), dependencies: [
            .domain(target: .MassageDomain)
        ])
    ]
)
