import ProjectDescription

// swiftlint: disable all
public extension TargetDependency {
    struct Feature {}
    struct Domain {}
    struct Core {}
    struct Shared {}
}

public extension TargetDependency.Feature {
    static let MainFeatureInterface = TargetDependency.project(
        target: ModulePaths.Feature.MainFeature.targetName(type: .interface),
        path: .relativeToFeature(ModulePaths.Feature.MainFeature.rawValue)
    )
    static let MainFeature = TargetDependency.project(
        target: ModulePaths.Feature.MainFeature.targetName(type: .sources),
        path: .relativeToFeature(ModulePaths.Feature.MainFeature.targetName(type: .sources))
    )
    static let RootFeatureInterface = TargetDependency.project(
        target: ModulePaths.Feature.RootFeature.targetName(type: .interface),
        path: .relativeToFeature(ModulePaths.Feature.RootFeature.rawValue)
    )
    static let RootFeature = TargetDependency.project(
        target: ModulePaths.Feature.RootFeature.targetName(type: .sources),
        path: .relativeToFeature(ModulePaths.Feature.RootFeature.targetName(type: .sources))
    )
    static let SigninFeatureInterface = TargetDependency.project(
        target: ModulePaths.Feature.SigninFeature.targetName(type: .interface),
        path: .relativeToFeature(ModulePaths.Feature.SigninFeature.rawValue)
    )
    static let SigninFeature = TargetDependency.project(
        target: ModulePaths.Feature.SigninFeature.targetName(type: .sources),
        path: .relativeToFeature(ModulePaths.Feature.SigninFeature.targetName(type: .sources))
    )
    static let BaseFeature = TargetDependency.project(
        target: ModulePaths.Feature.BaseFeature.targetName(type: .sources),
        path: .relativeToFeature(ModulePaths.Feature.BaseFeature.targetName(type: .sources))
    )
}

public extension TargetDependency.Domain {
    static let AuthDomainTesting = TargetDependency.project(
        target: ModulePaths.Domain.AuthDomain.targetName(type: .testing),
        path: .relativeToDomain(ModulePaths.Domain.AuthDomain.targetName(type: .testing))
    )
    static let AuthDomainInterface = TargetDependency.project(
        target: ModulePaths.Domain.AuthDomain.targetName(type: .interface),
        path: .relativeToDomain(ModulePaths.Domain.AuthDomain.targetName(type: .interface))
    )
    static let AuthDomain = TargetDependency.project(
        target: ModulePaths.Domain.AuthDomain.targetName(type: .sources),
        path: .relativeToDomain(ModulePaths.Domain.AuthDomain.targetName(type: .sources))
    )
    static let BaseDomain = TargetDependency.project(
        target: ModulePaths.Domain.BaseDomain.targetName(type: .sources),
        path: .relativeToDomain(ModulePaths.Domain.BaseDomain.targetName(type: .sources))
    )
}

public extension TargetDependency.Core {
    static let DWebKit = TargetDependency.project(
        target: ModulePaths.Core.DWebKit.targetName(type: .sources),
        path: .relativeToCore(ModulePaths.Core.DWebKit.targetName(type: .sources))
    )
    static let DesignSystem = TargetDependency.project(
        target: ModulePaths.Core.DesignSystem.targetName(type: .sources),
        path: .relativeToCore(ModulePaths.Core.DesignSystem.targetName(type: .sources))
    )
}

public extension TargetDependency.Shared {
    static let UtilityModule = TargetDependency.project(
        target: ModulePaths.Shared.UtilityModule.targetName(type: .sources),
        path: .relativeToShared(ModulePaths.Shared.UtilityModule.targetName(type: .sources))
    )
    static let GlobalThirdPartyLibrary = TargetDependency.project(
        target: ModulePaths.Shared.GlobalThirdPartyLibrary.targetName(type: .sources),
        path: .relativeToShared(ModulePaths.Shared.GlobalThirdPartyLibrary.targetName(type: .sources))
    )
}
