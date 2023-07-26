import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.module(
    name: ModulePaths.Feature.MassageFeature.rawValue,
    targets: [
        .implements(module: .feature(.MassageFeature), dependencies: [
            .feature(target: .BaseFeature),
            .domain(target: .MassageDomain, type: .interface),
            .domain(target: .UserDomain, type: .interface)
        ]),
        .tests(module: .feature(.MassageFeature), dependencies: [
            .feature(target: .MassageFeature),
            .domain(target: .MassageDomain, type: .testing),
            .domain(target: .UserDomain, type: .testing)
        ]),
        .demo(module: .feature(.NoticeFeature), dependencies: [
            .feature(target: .NoticeFeature),
            .domain(target: .MassageDomain, type: .testing),
            .domain(target: .UserDomain, type: .testing)
        ])
    ]
)
