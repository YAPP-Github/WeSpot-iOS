//
//  Project+Templates.swift
//  ProjectDescriptionHelpers
//
//  Created by eunseou on 6/10/24.
//

import ProjectDescription

//additionalFiles : Xcode에서 자동으로 연결 해주지 않는 파일을 연결 하기 위해 사용하는 인스턴스 프로퍼티
// options : Xcode > Setting에 대한 설정을 정의함


extension Project {

    static func makeProject(
        module: ModulePaths,
        targets: [Target],
        organizationName: String? = nil,
        options: Project.Options = .options(
            disableBundleAccessors: true,
            disableSynthesizedResourceAccessors: true
        ),
        packages: [Package] = [],
        schemes: [Scheme] = [],
        settings: Settings? = nil,
        fileHeaderTemplate: FileHeaderTemplate? = nil,
        additionalFiles: [FileElement] = [],
        resourceSynthesizers: [ResourceSynthesizer] = []
    ) -> Self {
        
        let name: String
        switch module {
        case .feature(let feature):
            name = feature.name
        case .domain(let domain):
            name = domain.name
        case .service(let service):
            name = service.name
        case .shared(let shared):
            name = shared.name
        case .core(let core):
            name = core.name
        }
        
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
