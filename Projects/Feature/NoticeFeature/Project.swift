import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.module(
    name: ModulePaths.Feature.NoticeFeature.rawValue,
    targets: [
        .implements(module: .feature(.NoticeFeature), dependencies: [
            .feature(target: .BaseFeature),
            .feature(target: .DetailNoticeFeature),
            .feature(target: .ConfirmationDialogFeature),
            .domain(target: .NoticeDomain, type: .interface),
            .domain(target: .UserDomain, type: .interface)
        ]),
        .tests(module: .feature(.NoticeFeature), dependencies: [
            .feature(target: .NoticeFeature),
            .domain(target: .UserDomain, type: .testing),
            .domain(target: .NoticeDomain, type: .testing),
        ]),
        .demo(module: .feature(.NoticeFeature), dependencies: [
            .feature(target: .NoticeFeature),
            .domain(target: .NoticeDomain, type: .testing),
            .domain(target: .UserDomain, type: .testing)
        ])
    ]
)
