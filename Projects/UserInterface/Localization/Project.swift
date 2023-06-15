import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin
import L10nPlugin

let project = Project.makeModule(
    name: ModulePaths.UserInterface.Localization.rawValue,
    product: .framework,
    targets: [],
    internalDependencies: [],
    resources: ["Resources/**"],
    resourceSynthesizers: [.l10n()]
)
