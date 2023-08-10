import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.UserInterface.DesignSystem.rawValue,
    targets: [
        .implements(
            module: .userInterface(.DesignSystem),
            product: .framework,
            spec: .init(
                resources: ["Resources/**"],
                dependencies: [
                    .SPM.Anim,
                    .SPM.MSGLayout,
                    .SPM.Lottie,
                    .userInterface(target: .DWebKit),
                    .shared(target: .GlobalThirdPartyLibrary),
                    .shared(target: .UIKitUtil)
                ]
            )
        ),
        .demo(module: .userInterface(.DesignSystem), dependencies: [
            .userInterface(target: .DesignSystem)
        ])
    ],
    resourceSynthesizers: .default + [
        .custom(name: "Lottie", parser: .json, extensions: ["json"])
    ]
)
