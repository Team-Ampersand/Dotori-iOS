import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.module(
    name: ModulePaths.Feature.SelfStudyFeature.rawValue,
    targets: [
        .implements(module: .feature(.SelfStudyFeature), dependencies: [
            .feature(target: .BaseFeature),
            .domain(target: .AuthDomain, type: .interface)
        ]),
        .tests(module: .feature(.SelfStudyFeature), dependencies: [
            .feature(target: .SelfStudyFeature)
        ])
    ]
)
