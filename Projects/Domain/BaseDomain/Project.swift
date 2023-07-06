import ConfigurationPlugin
import DependencyPlugin
import EnvironmentPlugin
import Foundation
import ProjectDescription
import ProjectDescriptionHelpers

let name = ModulePaths.Domain.BaseDomain.rawValue

let isCI = (ProcessInfo.processInfo.environment["TUIST_CI"] ?? "0") == "1" ? true : false

let configurations: [Configuration] = isCI ?
    .default :
[
    .debug(name: .dev, xcconfig: .relativeToXCConfig(type: .dev, name: name)),
    .debug(name: .stage, xcconfig: .relativeToXCConfig(type: .stage, name: name)),
    .release(name: .prod, xcconfig: .relativeToXCConfig(type: .prod, name: name))
]

let project = Project.module(
    name: ModulePaths.Domain.BaseDomain.rawValue,
    targets: [
        .implements(
            module: .domain(.BaseDomain),
            dependencies: [
                .core(target: .JwtStore, type: .interface),
                .core(target: .Networking, type: .interface),
                .core(target: .KeyValueStore, type: .interface),
                .userInterface(target: .Localization),
                .shared(target: .GlobalThirdPartyLibrary),
                .shared(target: .UtilityModule)
            ]
        ),
        .tests(module: .domain(.BaseDomain), dependencies: [
            .domain(target: .BaseDomain)
        ])
    ]
)
