import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Feature.SigninFeature.rawValue,
    targets: [
        .interface(module: .feature(.SigninFeature), dependencies: [
            .feature(target: .BaseFeature, type: .interface)
        ]),
        .implements(module: .feature(.SigninFeature), dependencies: [
            .feature(target: .BaseFeature),
            .feature(target: .SigninFeature, type: .interface),
            .feature(target: .SignupFeature, type: .interface),
            .feature(target: .RenewalPasswordFeature, type: .interface),
            .domain(target: .AuthDomain, type: .interface),
            .SPM.GAuthSignin
        ]),
        .tests(module: .feature(.SigninFeature), dependencies: [
            .feature(target: .SigninFeature)
        ])
    ]
)
