import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.module(
    name: ModulePaths.Domain.UserDomain.rawValue,
    targets: [
        .interface(module: .domain(.UserDomain), dependencies: [
            .domain(target: .BaseDomain, type: .interface)
        ]),
        .implements(module: .domain(.UserDomain), dependencies: [
            .domain(target: .UserDomain, type: .interface),
            .domain(target: .BaseDomain),
            .core(target: .KeyValueStore, type: .interface),
            .core(target: .JwtStore, type: .interface)
        ]),
        .testing(module: .domain(.UserDomain), dependencies: [
            .domain(target: .UserDomain, type: .interface)
        ]),
        .tests(module: .domain(.UserDomain), dependencies: [
            .domain(target: .UserDomain),
            .domain(target: .UserDomain, type: .testing),
            .core(target: .KeyValueStore, type: .testing),
            .core(target: .JwtStore, type: .testing)
        ])
    ]
)
