import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.module(
    name: ModulePaths.Domain.SelfStudyDomain.rawValue,
    targets: [
        .interface(module: .domain(.SelfStudyDomain), dependencies: [
            .domain(target: .BaseDomain, type: .interface)
        ]),
        .implements(module: .domain(.SelfStudyDomain), dependencies: [
            .domain(target: .SelfStudyDomain, type: .interface),
            .domain(target: .BaseDomain)
        ]),
        .testing(module: .domain(.SelfStudyDomain), dependencies: [
            .domain(target: .SelfStudyDomain, type: .interface)
        ]),
        .tests(module: .domain(.SelfStudyDomain), dependencies: [
            .domain(target: .SelfStudyDomain),
            .domain(target: .SelfStudyDomain, type: .testing)
        ])
    ]
)
