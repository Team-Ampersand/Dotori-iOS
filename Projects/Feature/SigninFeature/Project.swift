import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Feature.SigninFeature.rawValue,
    targets: [
        .implements(module: .feature(.SigninFeature), dependencies: [
            .feature(target: .BaseFeature),
            .feature(target: .SignupFeature),
            .feature(target: .RenewalPasswordFeature),
            .domain(target: .AuthDomain, type: .interface)
        ]),
        .tests(module: .feature(.SigninFeature), dependencies: [
            .feature(target: .SigninFeature)
        ])
    ]
)
