import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Domain.AuthDomain.rawValue,
    targets: [
        .interface(
            module: .domain(.AuthDomain),
            spec: .init(
                infoPlist: .extendingDefault(
                    with: [
                        "CLIENT_ID": .string("$CLIENT_ID"),
                        "REDIRECT_URI": .string("$(REDIRECT_URI")
                    ]
                ),
                dependencies: [
                    .domain(target: .BaseDomain, type: .interface)
                ]
            )
        ),
        .implements(module: .domain(.AuthDomain), dependencies: [
            .domain(target: .AuthDomain, type: .interface),
            .domain(target: .BaseDomain),
            .SPM.GAuthSignin
        ]),
        .testing(module: .domain(.AuthDomain), dependencies: [
            .domain(target: .AuthDomain, type: .interface)
        ]),
        .tests(module: .domain(.AuthDomain), dependencies: [
            .domain(target: .AuthDomain),
            .domain(target: .AuthDomain, type: .testing)
        ])
    ]
)
