import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.module(
    name: ModulePaths.Feature.InputDialogFeature.rawValue,
    targets: [
        .interface(module: .feature(.InputDialogFeature), dependencies: [
            .feature(target: .BaseFeature, type: .interface)
        ]),
        .implements(
            module: .feature(.InputDialogFeature),
            dependencies: [
                .feature(target: .BaseFeature),
                .feature(target: .InputDialogFeature, type: .interface)
            ]
        ),
        .tests(
            module: .feature(.InputDialogFeature),
            dependencies: [
                .feature(target: .InputDialogFeature)
            ]
        ),
        .demo(
            module: .feature(.InputDialogFeature),
            dependencies: [
                .feature(target: .InputDialogFeature)
            ]
        )
    ]
)
