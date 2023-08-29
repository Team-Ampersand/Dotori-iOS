import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Feature.ConfirmationDialogFeature.rawValue,
    targets: [
        .interface(module: .feature(.ConfirmationDialogFeature), dependencies: [
            .feature(target: .BaseFeature, type: .interface)
        ]),
        .implements(
            module: .feature(.ConfirmationDialogFeature),
            dependencies: [
                .feature(target: .BaseFeature),
                .feature(target: .ConfirmationDialogFeature, type: .interface)
            ]
        ),
        .tests(
            module: .feature(.ConfirmationDialogFeature),
            dependencies: [
                .feature(target: .ConfirmationDialogFeature)
            ]
        ),
        .demo(
            module: .feature(.ConfirmationDialogFeature),
            dependencies: [
                .feature(target: .ConfirmationDialogFeature)
            ]
        )
    ]
)
