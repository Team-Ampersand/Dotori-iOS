import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Feature.RootFeature.rawValue,
    targets: [
        .implements(module: .feature(.RootFeature), dependencies: [
            .feature(target: .SplashFeature),
            .feature(target: .SigninFeature),
            .feature(target: .MainTabFeature),
            .feature(target: .BaseFeature)
        ])
    ]
)
