import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.module(
    name: ModulePaths.Domain.AuthDomain.rawValue,
    targets: [
        .interface(module: .domain(.AuthDomain)),
        .implements(module: .domain(.AuthDomain), dependencies: [
            .domain(target: .AuthDomain, type: .interface),
            .domain(target: .BaseDomain)
        ]),
        .testing(module: .domain(.AuthDomain), dependencies: [
            .domain(target: .AuthDomain, type: .interface)
        ]),
        .tests(module: .domain(.AuthDomain), dependencies: [
            .domain(target: .AuthDomain),
            .domain(target: .AuthDomain, type: .testing)
        ])
    ]
)
