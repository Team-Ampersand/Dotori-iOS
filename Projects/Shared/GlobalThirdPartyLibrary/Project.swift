import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: ModulePaths.Shared.GlobalThirdPartyLibrary.rawValue,
    product: .framework,
    targets: [],
    externalDependencies: [
        .SPM.Swinject
    ],
    internalDependencies: [
        .Shared.CombineUtility,
        .Shared.DateUtility,
        .Shared.Then
    ]
)
