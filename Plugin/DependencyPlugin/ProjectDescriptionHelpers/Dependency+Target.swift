import ProjectDescription

// swiftlint: disable all
public extension TargetDependency {
    struct Feature {}
    struct Domain {}
    struct Core {}
    struct Shared {}
}

public extension TargetDependency.Feature {
    static let RenewalPasswordFeatureInterface = TargetDependency.project(
        target: ModulePaths.Feature.RenewalPasswordFeature.targetName(type: .interface),
        path: .relativeToFeature(ModulePaths.Feature.RenewalPasswordFeature.rawValue)
    )
    static let RenewalPasswordFeature = TargetDependency.project(
        target: ModulePaths.Feature.RenewalPasswordFeature.targetName(type: .sources),
        path: .relativeToFeature(ModulePaths.Feature.RenewalPasswordFeature.rawValue)
    )
    static let SignupFeatureInterface = TargetDependency.project(
        target: ModulePaths.Feature.SignupFeature.targetName(type: .interface),
        path: .relativeToFeature(ModulePaths.Feature.SignupFeature.rawValue)
    )
    static let SignupFeature = TargetDependency.project(
        target: ModulePaths.Feature.SignupFeature.targetName(type: .sources),
        path: .relativeToFeature(ModulePaths.Feature.SignupFeature.rawValue)
    )
    static let MainFeatureInterface = TargetDependency.project(
        target: ModulePaths.Feature.MainFeature.targetName(type: .interface),
        path: .relativeToFeature(ModulePaths.Feature.MainFeature.rawValue)
    )
    static let MainFeature = TargetDependency.project(
        target: ModulePaths.Feature.MainFeature.targetName(type: .sources),
        path: .relativeToFeature(ModulePaths.Feature.MainFeature.rawValue)
    )
    static let RootFeature = TargetDependency.project(
        target: ModulePaths.Feature.RootFeature.targetName(type: .sources),
        path: .relativeToFeature(ModulePaths.Feature.RootFeature.rawValue)
    )
    static let SigninFeatureInterface = TargetDependency.project(
        target: ModulePaths.Feature.SigninFeature.targetName(type: .interface),
        path: .relativeToFeature(ModulePaths.Feature.SigninFeature.rawValue)
    )
    static let SigninFeature = TargetDependency.project(
        target: ModulePaths.Feature.SigninFeature.targetName(type: .sources),
        path: .relativeToFeature(ModulePaths.Feature.SigninFeature.rawValue)
    )
    static let BaseFeature = TargetDependency.project(
        target: ModulePaths.Feature.BaseFeature.targetName(type: .sources),
        path: .relativeToFeature(ModulePaths.Feature.BaseFeature.rawValue)
    )
}

public extension TargetDependency.Domain {
    static let AuthDomainTesting = TargetDependency.project(
        target: ModulePaths.Domain.AuthDomain.targetName(type: .testing),
        path: .relativeToDomain(ModulePaths.Domain.AuthDomain.rawValue)
    )
    static let AuthDomainInterface = TargetDependency.project(
        target: ModulePaths.Domain.AuthDomain.targetName(type: .interface),
        path: .relativeToDomain(ModulePaths.Domain.AuthDomain.rawValue)
    )
    static let AuthDomain = TargetDependency.project(
        target: ModulePaths.Domain.AuthDomain.targetName(type: .sources),
        path: .relativeToDomain(ModulePaths.Domain.AuthDomain.rawValue)
    )
    static let BaseDomain = TargetDependency.project(
        target: ModulePaths.Domain.BaseDomain.targetName(type: .sources),
        path: .relativeToDomain(ModulePaths.Domain.BaseDomain.rawValue)
    )
}

public extension TargetDependency.Core {
    static let JwtStoreTesting = TargetDependency.project(
        target: ModulePaths.Core.JwtStore.targetName(type: .testing),
        path: .relativeToCore(ModulePaths.Core.JwtStore.rawValue)
    )
    static let JwtStoreInterface = TargetDependency.project(
        target: ModulePaths.Core.JwtStore.targetName(type: .interface),
        path: .relativeToCore(ModulePaths.Core.JwtStore.rawValue)
    )
    static let JwtStore = TargetDependency.project(
        target: ModulePaths.Core.JwtStore.targetName(type: .sources),
        path: .relativeToCore(ModulePaths.Core.JwtStore.rawValue)
    )
    static let DWebKit = TargetDependency.project(
        target: ModulePaths.Core.DWebKit.targetName(type: .sources),
        path: .relativeToCore(ModulePaths.Core.DWebKit.rawValue)
    )
    static let DesignSystem = TargetDependency.project(
        target: ModulePaths.Core.DesignSystem.targetName(type: .sources),
        path: .relativeToCore(ModulePaths.Core.DesignSystem.rawValue)
    )
}

public extension TargetDependency.Shared {
    static let DateUtility = TargetDependency.project(
        target: ModulePaths.Shared.DateUtility.targetName(type: .sources),
        path: .relativeToShared(ModulePaths.Shared.DateUtility.rawValue)
    )
    static let CombineUtility = TargetDependency.project(
        target: ModulePaths.Shared.CombineUtility.targetName(type: .sources),
        path: .relativeToShared(ModulePaths.Shared.CombineUtility.rawValue)
    )
    static let Then = TargetDependency.project(
        target: ModulePaths.Shared.Then.targetName(type: .sources),
        path: .relativeToShared(ModulePaths.Shared.Then.rawValue)
    )
    static let UtilityModule = TargetDependency.project(
        target: ModulePaths.Shared.UtilityModule.targetName(type: .sources),
        path: .relativeToShared(ModulePaths.Shared.UtilityModule.rawValue)
    )
    static let GlobalThirdPartyLibrary = TargetDependency.project(
        target: ModulePaths.Shared.GlobalThirdPartyLibrary.targetName(type: .sources),
        path: .relativeToShared(ModulePaths.Shared.GlobalThirdPartyLibrary.rawValue)
    )
}
