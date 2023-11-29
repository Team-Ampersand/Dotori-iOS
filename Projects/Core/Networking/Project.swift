import ConfigurationPlugin
import DependencyPlugin
import EnvironmentPlugin
import Foundation
import ProjectDescription
import ProjectDescriptionHelpers

let name = ModulePaths.Core.Networking.rawValue

let configurations: [Configuration] = generateEnvironment == .ci ?
    .default :
    [
        .debug(name: .dev, xcconfig: .relativeToXCConfig(type: .dev, name: name)),
        .debug(name: .stage, xcconfig: .relativeToXCConfig(type: .stage, name: name)),
        .release(name: .prod, xcconfig: .relativeToXCConfig(type: .prod, name: name))
    ]

let project = Project.module(
    name: name,
    targets: [
        .interface(
            module: .core(.Networking),
            spec: .init(
                infoPlist: .extendingDefault(
                    with: [
                        "BASE_URL": .string("$(BASE_URL)")
                    ]
                ),
                dependencies: [
                    .SPM.Emdpoint
                ],
                settings: .settings(
                    base: env.baseSetting
                        .merging(.allLoadLDFlages),
                    configurations: configurations,
                    defaultSettings: .recommended
                )
            )
        ),
        .implements(
            module: .core(.Networking),
            dependencies: [
                .core(target: .Networking, type: .interface),
                .core(target: .JwtStore, type: .interface),
                .core(target: .KeyValueStore, type: .interface),
                .shared(target: .GlobalThirdPartyLibrary)
            ]
        ),
        .testing(module: .core(.Networking), dependencies: [
            .core(target: .Networking, type: .interface)
        ]),
        .tests(module: .core(.Networking), dependencies: [
            .core(target: .Networking)
        ])
    ]
)
