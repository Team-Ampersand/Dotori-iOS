import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.module(
    name: ModulePaths.Feature.ConfirmationDialogFeature.rawValue,
    targets: [
        .implements(
            module: .feature(.ConfirmationDialogFeature),
            dependencies: [
                .feature(target: .BaseFeature)
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
