import ProjectDescription
import ProjectDescriptionHelpers
import ConfigurationPlugin
import DependencyPlugin
import Foundation

let name = ModulePaths.Domain.BaseDomain.rawValue

let isCI = (ProcessInfo.processInfo.environment["TUIST_CI"] ?? "0") == "1" ? true : false

let configurations: [Configuration] = isCI ?
[
    .debug(name: .dev, xcconfig: .shared),
    .debug(name: .stage, xcconfig: .shared),
    .release(name: .prod, xcconfig: .shared)
] :
[
    .debug(name: .dev, xcconfig: .relativeToXCConfig(type: .dev, name: name)),
    .debug(name: .stage, xcconfig: .relativeToXCConfig(type: .stage, name: name)),
    .release(name: .prod, xcconfig: .relativeToXCConfig(type: .prod, name: name))
]

let project = Project.makeModule(
    name: name,
    product: .framework,
    targets: [.unitTest],
    externalDependencies: [
        .SPM.Emdpoint
    ],
    internalDependencies: [
        .userInterface(target: .Localization),
        .core(target: .JwtStore, type: .interface),
        .shared(target: .GlobalThirdPartyLibrary),
        .shared(target: .UtilityModule)
    ],
    additionalPlistRows: [
        "BASE_URL": .string("$(BASE_URL)")
    ],
    configurations: configurations
)
