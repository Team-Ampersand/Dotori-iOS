import Foundation
import EnvironmentPlugin
import ProjectDescription

public extension Project {
    static func module(
        name: String,
        options: Options = .options(),
        packages: [Package] = [],
        settings: Settings? = nil,
        targets: [Target],
        fileHeaderTemplate: FileHeaderTemplate? = nil,
        additionalFiles: [FileElement] = [],
        resourceSynthesizers: [ResourceSynthesizer] = .default,
        hasDemo: Bool = false
    ) -> Project {
        return Project(
            name: name,
            organizationName: env.organizationName,
            options: options,
            packages: packages,
            settings: settings,
            targets: targets,
            schemes: hasDemo ?
                [.makeScheme(target: .dev, name: name)] :
                [.makeScheme(target: .dev, name: name), .makeDemoScheme(target: .dev, name: name)],
            fileHeaderTemplate: fileHeaderTemplate,
            additionalFiles: additionalFiles,
            resourceSynthesizers: resourceSynthesizers
        )
    }
}
