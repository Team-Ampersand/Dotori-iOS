import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.module(
    name: ModulePaths.Feature.SplashFeature.rawValue,
    targets: [
        .implements(module: .feature(.SplashFeature), dependencies: [
            .feature(target: .BaseFeature),
            .domain(target: .AuthDomain, type: .interface)
        ]),
        .tests(module: .feature(.SplashFeature), dependencies: [
            .feature(target: .SplashFeature)
        ])
    ]
)
