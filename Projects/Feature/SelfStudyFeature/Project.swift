import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.module(
    name: ModulePaths.Feature.SelfStudyFeature.rawValue,
    targets: [
        .implements(module: .feature(.SelfStudyFeature), dependencies: [
            .feature(target: .BaseFeature),
            .domain(target: .SelfStudyDomain, type: .interface)
        ]),
        .tests(module: .feature(.SelfStudyFeature), dependencies: [
            .feature(target: .SelfStudyFeature),
            .domain(target: .SelfStudyDomain, type: .testing)
        ]),
        .demo(
            module: .feature(.SelfStudyFeature),
            dependencies: [
                .feature(target: .SelfStudyFeature),
                .domain(target: .SelfStudyDomain, type: .testing)
            ]
        )
    ]
)
