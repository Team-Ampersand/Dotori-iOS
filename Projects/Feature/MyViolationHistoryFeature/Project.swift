import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.module(
    name: ModulePaths.Feature.MyViolationHistoryFeature.rawValue,
    targets: [
        .implements(module: .feature(.MyViolationHistoryFeature), dependencies: [
            .feature(target: .BaseFeature)
        ]),
        .tests(module: .feature(.MyViolationHistoryFeature), dependencies: [
            .feature(target: .MyViolationHistoryFeature)
        ]),
        .demo(module: .feature(.MyViolationHistoryFeature), dependencies: [
            .feature(target: .MyViolationHistoryFeature)
        ])
    ]
)
