import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Feature.MainTabFeature.rawValue,
    targets: [
        .implements(module: .feature(.MainTabFeature), dependencies: [
            .feature(target: .BaseFeature),
            .feature(target: .HomeFeature),
            .feature(target: .NoticeFeature),
            .feature(target: .SelfStudyFeature),
            .feature(target: .MassageFeature),
            .feature(target: .MusicFeature)
        ]),
        .tests(module: .feature(.MainTabFeature), dependencies: [
            .feature(target: .MainTabFeature)
        ])
    ]
)
