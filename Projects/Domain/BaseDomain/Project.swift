import ConfigurationPlugin
import DependencyPlugin
import EnvironmentPlugin
import Foundation
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Domain.BaseDomain.rawValue,
    targets: [
        .interface(module: .domain(.BaseDomain), dependencies: [
            .userInterface(target: .Localization)
        ]),
        .implements(
            module: .domain(.BaseDomain),
            dependencies: [
                .domain(target: .BaseDomain, type: .interface),
                .core(target: .JwtStore, type: .interface),
                .core(target: .Networking, type: .interface),
                .core(target: .KeyValueStore, type: .interface),
                .shared(target: .GlobalThirdPartyLibrary),
                .shared(target: .UtilityModule)
            ]
        ),
        .tests(module: .domain(.BaseDomain), dependencies: [
            .domain(target: .BaseDomain)
        ])
    ]
)
