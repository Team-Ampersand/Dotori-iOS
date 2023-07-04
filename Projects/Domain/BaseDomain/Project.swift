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
            product: .framework,
            spec: TargetSpec(
                infoPlist: .extendingDefault(
                    with: [
                        "BASE_URL": .string("$(BASE_URL)")
                    ]
                ),
                dependencies: [
                    .SPM.Emdpoint,
                    .core(target: .JwtStore, type: .interface),
                    .core(target: .KeyValueStore, type: .interface),
                    .userInterface(target: .Localization),
                    .shared(target: .GlobalThirdPartyLibrary),
                    .shared(target: .UtilityModule)
                ],
                settings: .settings(
                    base: env.baseSetting
                        .merging(.codeSign)
                        .merging(.allLoadLDFlages),
                    configurations: configurations,
                    defaultSettings: .recommended
                )
            )
        ),
        .tests(module: .domain(.BaseDomain), dependencies: [
            .domain(target: .BaseDomain)
        ])
    ]
)
