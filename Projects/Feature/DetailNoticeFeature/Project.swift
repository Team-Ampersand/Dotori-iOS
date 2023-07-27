import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.module(
    name: ModulePaths.Feature.DetailNoticeFeature.rawValue,
    targets: [
        .implements(module: .feature(.DetailNoticeFeature), dependencies: [
            .feature(target: .BaseFeature),
            .domain(target: .NoticeDomain, type: .interface),
            .domain(target: .UserDomain, type: .interface)
        ]),
        .tests(module: .feature(.DetailNoticeFeature), dependencies: [
            .feature(target: .DetailNoticeFeature),
            .domain(target: .NoticeDomain, type: .testing),
            .domain(target: .UserDomain, type: .testing)
        ]),
        .demo(module: .feature(.DetailNoticeFeature), dependencies: [
            .feature(target: .DetailNoticeFeature),
            .domain(target: .NoticeDomain, type: .testing),
            .domain(target: .UserDomain, type: .testing)
        ])
    ]
)
