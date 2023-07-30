import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.module(
    name: ModulePaths.Feature.BaseFeature.rawValue,
    targets: [
        .interface(module: .feature(.BaseFeature), dependencies: [
            .SPM.Moordinator
        ]),
        .implements(module: .feature(.BaseFeature), product: .framework, dependencies: [
            .SPM.Store,
            .SPM.IQKeyboardManagerSwift,
            .SPM.Nuke,
            .feature(target: .BaseFeature, type: .interface),
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
