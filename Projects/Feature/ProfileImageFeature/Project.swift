import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Feature.ProfileImageFeature.rawValue,
    targets: [
        .interface(module: .feature(.ProfileImageFeature), dependencies: [
            .feature(target: .BaseFeature, type: .interface)
        ]),
        .implements(module: .feature(.ProfileImageFeature), dependencies: [
            .feature(target: .BaseFeature),
            .feature(target: .ProfileImageFeature, type: .interface),
            .domain(target: .UserDomain, type: .interface),
            .SPM.YPImagePicker
        ]),
        .tests(module: .feature(.ProfileImageFeature), dependencies: [
            .feature(target: .ProfileImageFeature),
            .domain(target: .UserDomain, type: .testing)
        ]),
        .demo(module: .feature(.ProfileImageFeature), dependencies: [
            .feature(target: .ProfileImageFeature),
            .domain(target: .UserDomain, type: .testing)
        ])
    ]
)
