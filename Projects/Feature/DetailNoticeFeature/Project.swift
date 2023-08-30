import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Feature.DetailNoticeFeature.rawValue,
    targets: [
        .interface(module: .feature(.DetailNoticeFeature), dependencies: [
            .feature(target: .BaseFeature, type: .interface)
        ]),
        .implements(module: .feature(.DetailNoticeFeature), dependencies: [
            .feature(target: .BaseFeature),
            .feature(target: .DetailNoticeFeature, type: .interface),
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
