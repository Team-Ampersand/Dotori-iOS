import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

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
