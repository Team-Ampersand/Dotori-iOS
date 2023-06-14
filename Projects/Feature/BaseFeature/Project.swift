import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.module(
    name: ModulePaths.Feature.BaseFeature.rawValue,
    targets: [
        .implements(module: .feature(.BaseFeature), product: .framework, dependencies: [
            .SPM.MSGLayout,
            .SPM.Moordinator,
            .SPM.Store,
            .SPM.IQKeyboardManagerSwift,
            .userInterface(target: .DesignSystem),
            .shared(target: .GlobalThirdPartyLibrary),
            .shared(target: .UtilityModule)
        ]),
        .tests(module: .feature(.BaseFeature), dependencies: [
            .feature(target: .BaseFeature)
        ])
    ]
)
