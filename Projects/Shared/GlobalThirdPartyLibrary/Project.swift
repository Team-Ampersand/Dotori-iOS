import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.module(
    name: ModulePaths.Shared.GlobalThirdPartyLibrary.rawValue,
    targets: [
        .implements(module: .shared(.GlobalThirdPartyLibrary), product: .framework, dependencies: [
            .SPM.Swinject,
            .SPM.Configure,
            .shared(target: .CombineUtility),
            .shared(target: .ConcurrencyUtil),
            .shared(target: .DateUtility)
        ])
    ]
)
