//
//  Project+Templates.swift
//  ProjectDescriptionHelpers
//
//  Created by Kim dohyun on 6/10/24.
//

import ProjectDescription

//additionalFiles : Xcode에서 자동으로 연결 해주지 않는 파일을 연결 하기 위해 사용하는 인스턴스 프로퍼티
// options : Xcode > Setting에 대한 설정을 정의함


//name, target
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
}

extension Project {

    static func makeProject(
        name: String,
        organizationName: String?,
        options: Project.Options,
        packages: [Package],
        settings: Settings?,
        targets: [Target],
        schemes: [Scheme],
        fileHeaderTemplate: FileHeaderTemplate? = nil,
        additionalFiles: [FileElement],
        resourceSynthesizers: [ResourceSynthesizer]
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



let app = Project
    .makeProject(
        name: <#T##String#>,
        organizationName: <#T##String?#>,
        options: <#T##Project.Options#>,
        packages: <#T##[Package]#>,
        settings: <#T##Settings?#>,
        targets: <#T##[Target]#>,
        schemes: <#T##[Scheme]#>,
        additionalFiles: <#T##[FileElement]#>,
        resourceSynthesizers: <#T##[ResourceSynthesizer]#>
    )
