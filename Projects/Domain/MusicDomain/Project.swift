import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.module(
    name: ModulePaths.Domain.MusicDomain.rawValue,
    targets: [
        .interface(module: .domain(.MusicDomain), dependencies: [
            .domain(target: .BaseDomain, type: .interface)
        ]),
        .implements(module: .domain(.MusicDomain), dependencies: [
            .domain(target: .BaseDomain),
            .domain(target: .MusicDomain, type: .interface)
        ]),
        .testing(module: .domain(.MusicDomain), dependencies: [
            .domain(target: .MusicDomain, type: .interface)
        ]),
        .tests(module: .domain(.MusicDomain), dependencies: [
            .domain(target: .MusicDomain),
            .domain(target: .MusicDomain, type: .testing)
        ])
    ]
)
