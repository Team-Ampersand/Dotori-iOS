import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Feature.MainTabFeature.rawValue,
    targets: [
        .interface(module: .feature(.MainTabFeature), dependencies: [
            .feature(target: .BaseFeature, type: .interface)
        ]),
        .implements(module: .feature(.MainTabFeature), dependencies: [
            .feature(target: .MainTabFeature, type: .interface),
            .feature(target: .BaseFeature, type: .interface),
            .feature(target: .HomeFeature, type: .interface),
            .feature(target: .NoticeFeature, type: .interface),
            .feature(target: .SelfStudyFeature, type: .interface),
            .feature(target: .MassageFeature, type: .interface),
            .feature(target: .MusicFeature, type: .interface)
        ]),
        .tests(module: .feature(.MainTabFeature), dependencies: [
            .feature(target: .MainTabFeature)
        ])
    ]
)
