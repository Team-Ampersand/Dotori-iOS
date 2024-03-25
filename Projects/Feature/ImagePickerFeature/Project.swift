import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Feature.ImagePickerFeature.rawValue,
    targets: [
        .interface(module: .feature(.ImagePickerFeature), dependencies: [
            .feature(target: .BaseFeature, type: .interface)
        ]),
        .implements(module: .feature(.ImagePickerFeature), dependencies: [
            .feature(target: .BaseFeature),
            .feature(target: .ImagePickerFeature, type: .interface)
        ]),
        .tests(module: .feature(.ImagePickerFeature), dependencies: [
            .feature(target: .ImagePickerFeature)
        ]),
        .demo(module: .feature(.ImagePickerFeature), dependencies: [
            .feature(target: .ImagePickerFeature)
        ])
    ]
)
