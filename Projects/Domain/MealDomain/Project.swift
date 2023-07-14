import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.module(
    name: ModulePaths.Domain.MealDomain.rawValue,
    targets: [
        .interface(module: .domain(.MealDomain)),
        .implements(module: .domain(.MealDomain), dependencies: [
            .SPM.NeiSwift,
            .domain(target: .MealDomain, type: .interface),
            .domain(target: .BaseDomain)
        ]),
        .testing(module: .domain(.MealDomain), dependencies: [
            .domain(target: .MealDomain, type: .interface)
        ]),
        .tests(module: .domain(.MealDomain), dependencies: [
            .domain(target: .MealDomain),
            .domain(target: .MealDomain, type: .testing)
        ])
    ]
)
