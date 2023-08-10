import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Feature.ProposeMusicFeature.rawValue,
    targets: [
        .implements(module: .feature(.ProposeMusicFeature), dependencies: [
            .feature(target: .BaseFeature),
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
