import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.module(
    name: ModulePaths.Feature.MusicFeature.rawValue,
    targets: [
        .implements(module: .feature(.MusicFeature), dependencies: [
            .feature(target: .BaseFeature),
            .feature(target: .ProposeMusicFeature),
            .domain(target: .MusicDomain, type: .interface),
            .domain(target: .UserDomain, type:. interface)
        ]),
        .tests(module: .feature(.MusicFeature), dependencies: [
            .feature(target: .MusicFeature),
            .domain(target: .MusicDomain, type: .testing),
            .domain(target: .UserDomain, type:. testing)
        ]),
        .demo(module: .feature(.MusicFeature), dependencies: [
            .feature(target: .MusicFeature),
            .domain(target: .MusicDomain, type: .testing),
            .domain(target: .UserDomain, type:. testing)
        ])
    ]
)
