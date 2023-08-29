import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Feature.SplashFeature.rawValue,
    targets: [
        .interface(module: .feature(.SplashFeature), dependencies: [
            .feature(target: .BaseFeature, type: .interface)
        ]),
        .implements(module: .feature(.SplashFeature), dependencies: [
            .feature(target: .BaseFeature),
            .feature(target: .SplashFeature, type: .interface),
            .domain(target: .AuthDomain, type: .interface)
        ]),
        .tests(module: .feature(.SplashFeature), dependencies: [
            .feature(target: .SplashFeature),
            .domain(target: .AuthDomain, type: .testing)
        ])
    ]
)
