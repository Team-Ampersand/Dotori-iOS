import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Feature.MusicFeature.rawValue,
    targets: [
        .interface(module: .feature(.MusicFeature), dependencies: [
            .feature(target: .BaseFeature, type: .interface)
        ]),
        .implements(module: .feature(.MusicFeature), dependencies: [
            .feature(target: .BaseFeature),
            .feature(target: .MusicFeature, type: .interface),
            .feature(target: .ProposeMusicFeature, type: .interface),
            .domain(target: .MusicDomain, type: .interface),
            .domain(target: .UserDomain, type: .interface)
        ]),
        .tests(module: .feature(.MusicFeature), dependencies: [
            .feature(target: .MusicFeature),
            .domain(target: .MusicDomain, type: .testing),
            .domain(target: .UserDomain, type: .testing)
        ]),
        .demo(module: .feature(.MusicFeature), dependencies: [
            .feature(target: .MusicFeature),
            .domain(target: .MusicDomain, type: .testing),
            .domain(target: .UserDomain, type: .testing)
        ])
    ]
)
