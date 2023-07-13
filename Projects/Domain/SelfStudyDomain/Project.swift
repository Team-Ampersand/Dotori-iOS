import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.module(
    name: ModulePaths.Domain.SelfStudyDomain.rawValue,
    targets: [
        .interface(module: .domain(.SelfStudyDomain)),
        .implements(module: .domain(.SelfStudyDomain), dependencies: [
            .domain(target: .SelfStudyDomain, type: .interface),
            .domain(target: .BaseDomain)
        ]),
        .testing(module: .domain(.SelfStudyDomain), dependencies: [
            .domain(target: .SelfStudyDomain, type: .interface)
        ]),
        .tests(module: .domain(.SelfStudyDomain), dependencies: [
            .domain(target: .SelfStudyDomain)
        ])
    ]
)
