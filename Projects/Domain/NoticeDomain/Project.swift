import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Domain.NoticeDomain.rawValue,
    targets: [
        .interface(module: .domain(.NoticeDomain), dependencies: [
            .domain(target: .BaseDomain, type: .interface)
        ]),
        .implements(module: .domain(.NoticeDomain), dependencies: [
            .domain(target: .NoticeDomain, type: .interface),
            .domain(target: .BaseDomain)
        ]),
        .testing(module: .domain(.NoticeDomain), dependencies: [
            .domain(target: .NoticeDomain, type: .interface)
        ]),
        .tests(module: .domain(.NoticeDomain), dependencies: [
            .domain(target: .NoticeDomain),
            .domain(target: .NoticeDomain, type: .testing)
        ])
    ]
)
