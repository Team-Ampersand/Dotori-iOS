import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Feature.SelfStudyFeature.rawValue,
    targets: [
        .implements(module: .feature(.SelfStudyFeature), dependencies: [
            .feature(target: .BaseFeature),
            .feature(target: .FilterSelfStudyFeature, type: .interface),
            .domain(target: .SelfStudyDomain, type: .interface),
            .domain(target: .UserDomain, type: .interface)
        ]),
        .tests(module: .feature(.SelfStudyFeature), dependencies: [
            .feature(target: .SelfStudyFeature),
            .domain(target: .SelfStudyDomain, type: .testing),
            .domain(target: .UserDomain, type: .testing)
        ]),
        .demo(
            module: .feature(.SelfStudyFeature),
            dependencies: [
                .feature(target: .SelfStudyFeature),
                .domain(target: .SelfStudyDomain, type: .testing),
                .domain(target: .UserDomain, type: .testing)
            ]
        )
    ]
)
