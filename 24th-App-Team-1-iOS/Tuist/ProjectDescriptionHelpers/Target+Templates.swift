//
//  Target+Templates.swift
//  Packages
//
//  Created by Kim dohyun on 6/9/24.
//

import ProjectDescription

struct TargetConfig {
    var name: String
    var destinations: Destinations
    var product: Product
    var productName: String?
    var bundleId: String?
    var deploymentTargets: DeploymentTargets
    var infoPlist: InfoPlist?
    var sources: SourceFilesList?
    var resources: ResourceFileElements?
    var copyFiles: [CopyFilesAction]?
    var headers: Headers?
    var entitlements: Entitlements?
    var scripts: [TargetScript] = []
    var dependencies: [TargetDependency] = []
    var settings: Settings? = nil
    var coreDataModels: [CoreDataModel]
    var environmentVariables: [String: EnvironmentVariable]
    var launchArguments: [LaunchArgument] = []
    var additionalFiles: [FileElement] = []
    var buildRules: [BuildRule] = []
    var mergedBinaryType: MergedBinaryType = .disabled
    var mergeable: Bool
    
    init(
        name: String = "",
        destinations: Destinations = .iOS,
        product: Product = .staticLibrary,
        productName: String? = nil,
        bundleId: String? = "",
        deploymentTargets: DeploymentTargets = .iOS("15.0"),
        infoPlist: InfoPlist? = nil,
        sources: SourceFilesList? = nil,
        resources: ResourceFileElements? = nil,
        copyFiles: [CopyFilesAction]? = nil,
        headers: Headers? = nil,
        entitlements: Entitlements? = nil,
        scripts: [TargetScript] = [],
        dependencies: [TargetDependency] = [],
        settings: Settings? = nil,
        coreDataModels: [CoreDataModel] = [],
        environmentVariables: [String : EnvironmentVariable] = [:],
        launchArguments: [LaunchArgument] = [],
        buildRules: [BuildRule] = [],
        mergedBinaryType: MergedBinaryType = .disabled,
        mergeable: Bool = false
    ) {
        self.name = name
        self.destinations = destinations
        self.product = product
        self.productName = productName
        self.bundleId = bundleId
        self.deploymentTargets = deploymentTargets
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
        self.environmentVariables = environmentVariables
        self.launchArguments = launchArguments
        self.buildRules = buildRules
        self.mergedBinaryType = mergedBinaryType
        self.mergeable = mergeable
    }
    
    func makeApp(with name: String, bundleId: String, product: Product = .app, dependencies: [TargetDependency]) -> Target {
        .target(
            name: name,
            destinations: self.destinations,
            product: product,
            productName: self.productName,
            bundleId: bundleId,
            deploymentTargets: self.deploymentTargets,
            infoPlist: self.infoPlist,
            sources: self.sources,
            resources: self.resources,
            copyFiles: self.copyFiles,
            headers: self.headers,
            entitlements: self.entitlements,
            scripts: self.scripts,
            dependencies: dependencies,
            settings: self.settings,
            coreDataModels: self.coreDataModels,
            environmentVariables: self.environmentVariables,
            launchArguments: self.launchArguments,
            additionalFiles: self.additionalFiles,
            buildRules: self.buildRules,
            mergedBinaryType: self.mergedBinaryType,
            mergeable: self.mergeable
        )
    }
    
    
    func makeTarget(with name: String, bundleId: String, product: Product? = nil) -> Target {
        .target(
            name: name,
            destinations: destinations,
            product: product ?? self.product,
            productName: productName,
            bundleId: bundleId,
            deploymentTargets: deploymentTargets,
            infoPlist: infoPlist,
            sources: sources,
            resources: resources,
            copyFiles: copyFiles,
            headers: headers,
            entitlements: entitlements,
            scripts: scripts,
            dependencies: dependencies,
            settings: settings,
            coreDataModels: coreDataModels,
            environmentVariables: environmentVariables,
            launchArguments: launchArguments,
            additionalFiles: additionalFiles,
            buildRules: buildRules,
            mergedBinaryType: mergedBinaryType,
            mergeable: mergeable
        )
    }
}

extension Target {
    
    /**
     Feature Module Target 생성 메서드
     - Parameters:
        - module: ModulePaths Type
     - Returns: Target Type
     */
    public static func feature(module: ModulePaths.Feature, dependencies: [TargetDependency]) -> Self {
        TargetConfig(infoPlist: .default, sources: .sources, dependencies: dependencies)
            .makeTarget(with: module.name, bundleId: module.bundleId, product: .framework)
    }
    
    /**
     Domain Module Target 생성 메서드
     - Parameters:
        - module: ModulePaths Type
        - product: Target Product Type
     - Returns: Target Type
     */
    public static func domain(module: ModulePaths.Domain, dependencies: [TargetDependency]) -> Self {
        TargetConfig(infoPlist: .default, sources: .sources, dependencies: dependencies)
            .makeTarget(with: module.name, bundleId: module.bundleId, product: .framework)
    }
    
    /**
     Service Module Target 생성 메서드
     - Parameters:
        - module: ModulePaths Type
     - Returns: Target Type
     */
    public static func service(module: ModulePaths.Service, dependencies: [TargetDependency]) -> Self {
        TargetConfig(infoPlist: .default, sources: .sources, dependencies: dependencies)
            .makeTarget(with: module.name, bundleId: module.bundleId, product: .framework)
    }
    
    /**
     Core Module Target 생성 메서드
     - Parameters:
        - module: ModulePaths Type
     - Returns: Target Type
     */
    public static func core(module: ModulePaths.Core, dependencies: [TargetDependency] = []) -> Self {
        TargetConfig(infoPlist: .default, sources: .sources, dependencies: dependencies)
            .makeTarget(with: module.name, bundleId: module.bundleId, product: .framework)
    }
    
    /**
     share Module Target 생성 메서드
     - Parameters:
        - module: ModulePaths Type
     - Returns: Target Type
     */
    public static func share(module: ModulePaths.Shared, dependencies: [TargetDependency] = []) -> Self {
        TargetConfig(infoPlist: .default ,sources: .sources, resources: .resources, dependencies: dependencies, settings: module == .ThirdPartyLib ? .makeSettings() : nil)
            .makeTarget(with: module.name, bundleId: module.bundleId, product: .framework)
    }
    
    /**
     App Module Target 생성 메서드
     - Parameters:
        - module: ModulePaths Type
        - Returns: Target Type
     */
    public static func app(module: ModulePaths.App, dependencies: [TargetDependency]) -> Self {
        TargetConfig(infoPlist: .makeInfoPlist() ,sources: .sources, resources: .resources)
            .makeApp(with: module.appName, bundleId: module.appBundleId, dependencies: dependencies)
    }

}
