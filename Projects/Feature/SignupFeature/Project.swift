import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Feature.SignupFeature.rawValue,
    targets: [
        .interface(module: .feature(.SignupFeature), dependencies: [
            .feature(target: .BaseFeature, type: .interface)
        ]),
        .implements(module: .feature(.SignupFeature), dependencies: [
            .feature(target: .BaseFeature),
            .feature(target: .SignupFeature, type: .interface),
            .domain(target: .AuthDomain, type: .interface)
        ]),
        .tests(module: .feature(.SignupFeature), dependencies: [
            .feature(target: .SignupFeature)
        ])
    ]
)
