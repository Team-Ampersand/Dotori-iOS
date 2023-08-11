import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Feature.SignupFeature.rawValue,
    targets: [
        .implements(module: .feature(.SignupFeature), dependencies: [
            .feature(target: .BaseFeature),
            .domain(target: .AuthDomain, type: .interface)
        ]),
        .tests(module: .feature(.SignupFeature), dependencies: [
            .feature(target: .SignupFeature)
        ])
    ]
)
