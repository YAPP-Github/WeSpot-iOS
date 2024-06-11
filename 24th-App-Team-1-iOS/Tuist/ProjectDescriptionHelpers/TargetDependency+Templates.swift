//
//  TargetDependency+Templates.swift
//  ProjectDescriptionHelpers
//
//  Created by Kim dohyun on 6/10/24.
//

import ProjectDescription

extension TargetDependency {
    struct SPM { }
}


extension TargetDependency {
    
    static func feature(module: ModulePaths.Feature) -> Self {
        .project(target: module.name, path: .relativeToRoot("Feature/\(module.name)"))
    }
    
    static func domain(module: ModulePaths.Domain) -> Self {
        .project(target: module.name, path: .relativeToRoot("Domain/\(module.name)"))
    }
    
    static func service(module: ModulePaths.Service) -> Self {
        .project(target: module.name, path: .relativeToRoot("Service/\(module.name)"))
    }
    
    static func core(module: ModulePaths.Core) -> Self {
        .project(target: module.name, path: .relativeToRoot("Core/\(module.name)"))
    }
    
    static func share(module: ModulePaths.Share) -> Self {
        .project(target: module.name, path: .relativeToRoot("Share/\(module.name)"))
    }
}

extension TargetDependency.SPM {
    
    //MARK: Rx
    static let rxSwift: TargetDependency = .external(name: "RxSwift")
    static let rxCocoa: TargetDependency = .external(name: "RxCocoa")
    static let reactorKit: TargetDependency = .external(name: "ReactorKit")
    static let rxDataSources: TargetDependency = .external(name: "RxDataSources")
    
    //MARK: DesignSystems
    static let snapKit: TargetDependency = .external(name: "snapKit")
    static let then: TargetDependency = .external(name: "Then")
    
    //MARK: Network
    static let alamofire: TargetDependency = .external(name: "Alamofire")
    
    //MARK: DI
    static let swinject: TargetDependency = .external(name: "Swinject")
}
