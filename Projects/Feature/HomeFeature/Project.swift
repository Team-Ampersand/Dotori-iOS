import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Feature.HomeFeature.rawValue,
    targets: [
        .interface(module: .feature(.HomeFeature), dependencies: [
            .feature(target: .BaseFeature, type: .interface)
        ]),
        .implements(
            module: .feature(.HomeFeature),
            dependencies: [
                .feature(target: .BaseFeature),
                .feature(target: .HomeFeature, type: .interface),
                .feature(target: .ConfirmationDialogFeature, type: .interface),
                .feature(target: .MyViolationListFeature, type: .interface),
                .feature(target: .InputDialogFeature, type: .interface),
                .feature(target: .ProfileImageFeature, type: .interface),
                .domain(target: .SelfStudyDomain, type: .interface),
                .domain(target: .MassageDomain, type: .interface),
                .domain(target: .MealDomain, type: .interface),
                .domain(target: .UserDomain, type: .interface),
                .core(target: .Timer, type: .interface)
            ]
        ),
        .tests(
            module: .feature(.HomeFeature),
            dependencies: [
                .feature(target: .HomeFeature),
                .domain(target: .SelfStudyDomain, type: .testing),
                .domain(target: .MassageDomain, type: .testing),
                .domain(target: .UserDomain, type: .testing),
                .domain(target: .MealDomain, type: .testing),
                .core(target: .Timer, type: .testing)
            ]
        ),
        .demo(
            module: .feature(.HomeFeature),
            dependencies: [
                .feature(target: .HomeFeature),
                .domain(target: .SelfStudyDomain, type: .testing),
                .domain(target: .MassageDomain, type: .testing),
                .domain(target: .MealDomain, type: .testing),
                .core(target: .Timer, type: .testing)
            ]
        )
    ]
)
