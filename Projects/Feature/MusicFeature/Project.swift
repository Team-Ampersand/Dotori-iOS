import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.module(
    name: ModulePaths.Feature.MusicFeature.rawValue,
    targets: [
        .implements(module: .feature(.MusicFeature), dependencies: [
            .feature(target: .BaseFeature),
            .domain(target: .AuthDomain, type: .interface)
        ]),
        .tests(module: .feature(.MusicFeature), dependencies: [
            .feature(target: .MusicFeature)
        ])
    ]
)
