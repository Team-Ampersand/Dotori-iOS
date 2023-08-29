import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Feature.MyViolationListFeature.rawValue,
    targets: [
        .interface(module: .feature(.MyViolationListFeature), dependencies: [
            .feature(target: .BaseFeature, type: .interface)
        ]),
        .implements(module: .feature(.MyViolationListFeature), dependencies: [
            .feature(target: .BaseFeature),
            .feature(target: .MyViolationListFeature, type: .interface),
            .domain(target: .ViolationDomain, type: .interface)
        ]),
        .tests(module: .feature(.MyViolationListFeature), dependencies: [
            .feature(target: .MyViolationListFeature),
            .domain(target: .ViolationDomain, type: .testing)
        ]),
        .demo(module: .feature(.MyViolationListFeature), dependencies: [
            .feature(target: .MyViolationListFeature),
            .domain(target: .ViolationDomain, type: .testing)
        ])
    ]
)
