import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.module(
    name: ModulePaths.Domain.MassageDomain.rawValue,
    targets: [
        .interface(module: .domain(.MassageDomain), dependencies: [
            .domain(target: .BaseDomain, type: .interface)
        ]),
        .implements(module: .domain(.MassageDomain), dependencies: [
            .domain(target: .MassageDomain, type: .interface),
            .domain(target: .BaseDomain)
        ]),
        .testing(module: .domain(.MassageDomain), dependencies: [
            .domain(target: .MassageDomain, type: .interface)
        ]),
        .tests(module: .domain(.MassageDomain), dependencies: [
            .domain(target: .MassageDomain),
            .domain(target: .MassageDomain, type: .testing)
        ])
    ]
)
