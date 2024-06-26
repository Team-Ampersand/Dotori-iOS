import DependencyPlugin
import EnvironmentPlugin
import Foundation
import ProjectDescription
import ProjectDescriptionHelpers

let name = ModulePaths.Domain.MealDomain.rawValue

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
            module: .domain(.MealDomain),
            spec: .init(
                infoPlist: .extendingDefault(
                    with: [
                        "NEIS_API_KEY": .string("$(NEIS_API_KEY)")
                    ]
                ),
                dependencies: [
                    .SPM.CombineMiniature
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
            module: .domain(.MealDomain),
            dependencies: [
                .SPM.AsyncNeiSwift,
                .domain(target: .MealDomain, type: .interface),
                .domain(target: .BaseDomain),
                .core(target: .Database, type: .interface)
            ]
        ),
        .testing(module: .domain(.MealDomain), dependencies: [
            .domain(target: .MealDomain, type: .interface)
        ]),
        .tests(module: .domain(.MealDomain), dependencies: [
            .domain(target: .MealDomain),
            .domain(target: .MealDomain, type: .testing)
        ])
    ]
)
