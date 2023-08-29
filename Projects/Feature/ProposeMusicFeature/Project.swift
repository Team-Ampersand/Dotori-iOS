import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Feature.ProposeMusicFeature.rawValue,
    targets: [
        .interface(module: .feature(.ProposeMusicFeature), dependencies: [
            .feature(target: .BaseFeature, type: .interface)
        ]),
        .implements(module: .feature(.ProposeMusicFeature), dependencies: [
            .feature(target: .BaseFeature),
            .feature(target: .ProposeMusicFeature, type: .interface),
            .domain(target: .MusicDomain, type: .interface)
        ]),
        .tests(module: .feature(.ProposeMusicFeature), dependencies: [
            .feature(target: .ProposeMusicFeature),
            .domain(target: .MusicDomain, type: .testing)
        ]),
        .demo(module: .feature(.ProposeMusicFeature), dependencies: [
            .feature(target: .ProposeMusicFeature),
            .domain(target: .MusicDomain, type: .testing)
        ])
    ]
)
