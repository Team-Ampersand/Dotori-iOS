import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.module(
    name: ModulePaths.Domain.ViolationDomain.rawValue,
    targets: [
        .interface(module: .domain(.ViolationDomain)),
        .implements(module: .domain(.ViolationDomain), dependencies: [
            .domain(target: .ViolationDomain, type: .interface),
            .domain(target: .BaseDomain)
        ]),
        .testing(module: .domain(.ViolationDomain), dependencies: [
            .domain(target: .ViolationDomain, type: .interface)
        ]),
        .tests(module: .domain(.ViolationDomain), dependencies: [
            .domain(target: .ViolationDomain),
            .domain(target: .ViolationDomain, type: .testing)
        ])
    ]
)
