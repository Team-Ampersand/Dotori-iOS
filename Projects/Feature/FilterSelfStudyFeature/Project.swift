import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Feature.FilterSelfStudyFeature.rawValue,
    targets: [
        .interface(module: .feature(.FilterSelfStudyFeature), dependencies: [
            .feature(target: .BaseFeature, type: .interface)
        ]),
        .implements(
            module: .feature(.FilterSelfStudyFeature),
            dependencies: [
                .feature(target: .BaseFeature),
                .feature(target: .FilterSelfStudyFeature, type: .interface)
            ]
        ),
        .tests(
            module: .feature(.FilterSelfStudyFeature),
            dependencies: [
                .feature(target: .FilterSelfStudyFeature)
            ]
        ),
        .demo(
            module: .feature(.FilterSelfStudyFeature),
            dependencies: [
                .feature(target: .FilterSelfStudyFeature)
            ]
        )
    ]
)
