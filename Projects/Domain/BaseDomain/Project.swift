import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let name = ModulePaths.Domain.BaseDomain.rawValue
let project = Project.makeModule(
    name: name,
    product: .framework,
    targets: [.unitTest],
    externalDependencies: [
        .SPM.Emdpoint
    ],
    internalDependencies: [
        .Core.JwtStoreInterface,
        .Shared.GlobalThirdPartyLibrary,
        .Shared.UtilityModule
    ],
    additionalPlistRows: [
        "BASE_URL": .string("$(BASE_URL)")
    ],
    configurations: [
        .debug(name: .dev, xcconfig: .relativeToXCConfig(type: .dev, name: name)),
        .debug(name: .stage, xcconfig: .relativeToXCConfig(type: .stage, name: name)),
        .release(name: .prod, xcconfig: .relativeToXCConfig(type: .prod, name: name))
    ]
)
