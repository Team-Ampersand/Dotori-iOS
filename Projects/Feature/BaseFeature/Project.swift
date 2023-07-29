import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.module(
    name: ModulePaths.Feature.BaseFeature.rawValue,
    targets: [
        .implements(module: .feature(.BaseFeature), product: .framework, dependencies: [
            .SPM.Moordinator,
            .SPM.Store,
            .SPM.IQKeyboardManagerSwift,
            .SPM.Nuke,
            .userInterface(target: .DesignSystem),
            .userInterface(target: .Localization),
            .shared(target: .GlobalThirdPartyLibrary),
            .shared(target: .UtilityModule),
            .shared(target: .UIKitUtil)
        ]),
        .tests(module: .feature(.BaseFeature), dependencies: [
            .feature(target: .BaseFeature)
        ])
    ]
)
