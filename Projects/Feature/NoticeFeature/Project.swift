import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Feature.NoticeFeature.rawValue,
    targets: [
        .interface(module: .feature(.NoticeFeature), dependencies: [
            .feature(target: .BaseFeature, type: .interface)
        ]),
        .implements(module: .feature(.NoticeFeature), dependencies: [
            .feature(target: .BaseFeature),
            .feature(target: .NoticeFeature, type: .interface),
            .feature(target: .DetailNoticeFeature, type: .interface),
            .feature(target: .ConfirmationDialogFeature, type: .interface),
            .domain(target: .NoticeDomain, type: .interface),
            .domain(target: .UserDomain, type: .interface)
        ]),
        .tests(module: .feature(.NoticeFeature), dependencies: [
            .feature(target: .NoticeFeature),
            .domain(target: .UserDomain, type: .testing),
            .domain(target: .NoticeDomain, type: .testing)
        ]),
        .demo(module: .feature(.NoticeFeature), dependencies: [
            .feature(target: .NoticeFeature),
            .domain(target: .NoticeDomain, type: .testing),
            .domain(target: .UserDomain, type: .testing)
        ])
    ]
)
