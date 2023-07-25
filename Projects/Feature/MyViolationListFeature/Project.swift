import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.module(
    name: ModulePaths.Feature.MyViolationListFeature.rawValue,
    targets: [
        .implements(module: .feature(.MyViolationListFeature), dependencies: [
            .feature(target: .BaseFeature),
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
