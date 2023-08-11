import DependencyPlugin
import L10nPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: ModulePaths.UserInterface.Localization.rawValue,
    product: .framework,
    targets: [],
    internalDependencies: [],
    resources: ["Resources/**"],
    resourceSynthesizers: [.l10n()]
)
