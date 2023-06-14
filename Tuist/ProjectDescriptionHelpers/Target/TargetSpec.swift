import ConfigurationPlugin
import EnvironmentPlugin
import ProjectDescription

public struct TargetSpec {
    public let name: String
    public let platform: Platform
    public let product: Product
    public let productName: String?
    public let bundleId: String
    public let deploymentTarget: DeploymentTarget?
    public let infoPlist: InfoPlist?
    public let sources: SourceFilesList?
    public let resources: ResourceFileElements?
    public let copyFiles: [CopyFilesAction]?
    public let headers: Headers?
    public let entitlements: Path?
    public let scripts: [TargetScript]
    public let dependencies: [TargetDependency]
    public let settings: Settings?
    public let coreDataModels: [CoreDataModel]
    public let environment: [String : String]
    public let launchArguments: [LaunchArgument]
    public let additionalFiles: [FileElement]
    public let buildRules: [BuildRule]

    public init(
        name: String = "",
        platform: Platform = env.platform,
        product: Product = .staticLibrary,
        productName: String? = nil,
        bundleId: String? = nil,
        deploymentTarget: DeploymentTarget? = nil,
        infoPlist: InfoPlist = .default,
        sources: SourceFilesList? = .sources,
        resources: ResourceFileElements? = nil,
        copyFiles: [CopyFilesAction]? = nil,
        headers: Headers? = nil,
        entitlements: Path? = nil,
        scripts: [TargetScript] = env.isCI ? [] : [.swiftLint],
        dependencies: [TargetDependency] = [],
        settings: Settings? = nil,
        coreDataModels: [CoreDataModel] = [],
        environment: [String: String] = [:],
        launchArguments: [LaunchArgument] = [],
        additionalFiles: [FileElement] = [],
        buildRules: [BuildRule] = []
    ) {
        self.name = name
        self.platform = platform
        self.product = product
        self.productName = productName
        self.bundleId = bundleId ?? "\(env.organizationName).\(name)"
        self.deploymentTarget = deploymentTarget
        self.infoPlist = infoPlist
        self.sources = sources
        self.resources = resources
        self.copyFiles = copyFiles
        self.headers = headers
        self.entitlements = entitlements
        self.scripts = scripts
        self.dependencies = dependencies
        self.settings = settings
        self.coreDataModels = coreDataModels
        self.environment = environment
        self.launchArguments = launchArguments
        self.additionalFiles = additionalFiles
        self.buildRules = buildRules
    }

    func toTarget() -> Target {
        self.toTarget(with: self.name)
    }

    func toTarget(with name: String, product: Product? = nil) -> Target {
        Target(
            name: name,
            platform: platform,
            product: product ?? self.product,
            productName: productName,
            bundleId: bundleId,
            deploymentTarget: deploymentTarget,
            infoPlist: infoPlist,
            sources: sources,
            resources: resources,
            copyFiles: copyFiles,
            headers: headers,
            entitlements: entitlements,
            scripts: scripts,
            dependencies: dependencies,
            settings: settings ?? .settings(
                base: env.baseSetting
                    .merging(.codeSign)
                    .merging((product ?? self.product) == .framework ? .allLoadLDFlages : .ldFlages),
                configurations: [
                    .debug(name: .dev, xcconfig: .shared),
                    .debug(name: .stage, xcconfig: .shared),
                    .release(name: .prod, xcconfig: .shared)
                ],
                defaultSettings: .recommended
            ),
            coreDataModels: coreDataModels,
            environment: environment,
            launchArguments: launchArguments,
            additionalFiles: additionalFiles,
            buildRules: buildRules
        )
    }
}
