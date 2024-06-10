//
//  Project+Templates.swift
//  ProjectDescriptionHelpers
//
//  Created by Kim dohyun on 6/10/24.
//

import ProjectDescription

// name과 targets만 수정할 수 있게 하고, 다른 인자는 기본값을 사용하도록 설정
struct ProjectConfig {
    var name: String
    var organizationName: String?
    var options: Project.Options
    var packages: [Package]
    var targets: [Target]
    var schemes: [Scheme]
    var settings: Settings?
    var fileHeaderTemplate: FileHeaderTemplate?
    var additionalFiles: [FileElement]
    var resourceSynthesizers: [ResourceSynthesizer]

    init(
        name: String = "",
        organizationName: String? = nil,
        options: Project.Options = .options(
            disableBundleAccessors: true,
            disableSynthesizedResourceAccessors: true
        ),
        packages: [Package] = [],
        targets: [Target] = [],
        schemes: [Scheme] = [],
        settings: Settings? = nil,
        fileHeaderTemplate: FileHeaderTemplate? = nil,
        additionalFiles: [FileElement] = [],
        resourceSynthesizers: [ResourceSynthesizer] = []
    ) {
        self.name = name
        self.organizationName = organizationName
        self.options = options
        self.packages = packages
        self.targets = targets
        self.schemes = schemes
        self.settings = settings
        self.fileHeaderTemplate = fileHeaderTemplate
        self.additionalFiles = additionalFiles
        self.resourceSynthesizers = resourceSynthesizers
    }
    
    func makeProject(
        name: String,
        targets: [Target]
    ) -> Project {
        return Project(
            name: name,
            organizationName: organizationName,
            options: options,
            packages: packages,
            settings: settings,
            targets: targets,
            schemes: schemes,
            fileHeaderTemplate: fileHeaderTemplate,
            additionalFiles: additionalFiles,
            resourceSynthesizers: resourceSynthesizers
        )
    }
}

extension Project {
    /**
     Feature Module Project 생성 메서드
     - Parameters:
        - module: ModulePaths.Feature 타입
        - target: Target 배열
     - Returns: Project Type
     */
    static func feature(module: ModulePaths.Feature, targets: [Target] = []) -> Self {
        return ProjectConfig().makeProject(name: module.name, targets: targets)
    }


    /**
     Domain Module Project 생성 메서드
     - Parameters:
        - module: ModulePaths.Domain 타입
        - target: Target 배열
     - Returns: Project Type
     */
    static func domain(module: ModulePaths.Doamin, targets: [Target] = []) -> Self {
        return ProjectConfig().makeProject(name: module.name, targets: targets)
    }

    /**
     Service Module Project 생성 메서드
     - Parameters:
        - module: ModulePaths.Service 타입
        - target: Target 배열
     - Returns: Project Type
     */
    static func service(module: ModulePaths.Service, targets: [Target] = []) -> Self {
        return ProjectConfig().makeProject(name: module.name, targets: targets)
    }

    /**
     Core Module Project 생성 메서드
     - Parameters:
        - module: ModulePaths.Core 타입
        - target: Target 배열
     - Returns: Project Type
     */
    static func core(module: ModulePaths.Doamin, targets: [Target] = []) -> Self {
        return ProjectConfig().makeProject(name: module.name, targets: targets)
    }

    /**
     Shared Module Project 생성 메서드
     - Parameters:
        - module: ModulePaths.Shared 타입
        - target: Target 배열
     - Returns: Project Type
     */
    static func share(module: ModulePaths.Share, targets: [Target]) -> Self {
        return ProjectConfig().makeProject(name: module.name, targets: targets)
    }
}
