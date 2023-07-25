import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.module(
    name: ModulePaths.Feature.MyViolationHistoryFeature.rawValue,
    targets: [
        .implements(module: .feature(.MyViolationHistoryFeature), dependencies: [
            .feature(target: .BaseFeature),
            .domain(target: .ViolationDomain, type: .interface)
        ]),
        .tests(module: .feature(.MyViolationHistoryFeature), dependencies: [
            .feature(target: .MyViolationHistoryFeature),
            .domain(target: .ViolationDomain, type: .testing)
        ]),
        .demo(module: .feature(.MyViolationHistoryFeature), dependencies: [
            .feature(target: .MyViolationHistoryFeature),
            .domain(target: .ViolationDomain, type: .testing)
        ])
    ]
)
