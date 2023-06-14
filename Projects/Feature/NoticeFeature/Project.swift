import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.module(
    name: ModulePaths.Feature.NoticeFeature.rawValue,
    targets: [
        .implements(module: .feature(.NoticeFeature), dependencies: [
            .feature(target: .BaseFeature),
            .domain(target: .AuthDomain, type: .interface)
        ]),
        .tests(module: .feature(.NoticeFeature), dependencies: [
            .feature(target: .NoticeFeature)
        ])
    ]
)
