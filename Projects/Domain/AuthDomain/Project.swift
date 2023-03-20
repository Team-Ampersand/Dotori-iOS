import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: ModulePaths.Domain.AuthDomain.rawValue,
    product: .staticLibrary,
    targets: [.interface, .testing, .unitTest],
    internalDependencies: [
        .Domain.BaseDomain
    ],
    additionalPlistRows: [
        "BASE_URL": .string("$(BASE_URL)")
    ]
)
