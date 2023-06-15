import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: ModulePaths.Feature.BaseFeature.rawValue,
    product: .framework,
    targets: [.unitTest],
    externalDependencies: [
        .SPM.MSGLayout,
        .SPM.Moordinator,
        .SPM.Store,
        .SPM.IQKeyboardManagerSwift
    ],
    internalDependencies: [
        .userInterface(target: .DesignSystem),
        .userInterface(target: .Localization),
        .shared(target: .GlobalThirdPartyLibrary),
        .shared(target: .UtilityModule)
    ]
)
