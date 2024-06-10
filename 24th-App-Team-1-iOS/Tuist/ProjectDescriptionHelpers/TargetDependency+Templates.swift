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
        .project(target: module.name, path: .relativeToRoot("Feature/\(module.name)"), condition: .none)
    }
    
    static func domain(module: ModulePaths.Doamin) -> Self {
        .project(target: module.name, path: .relativeToRoot("Domain/\(module.name)"), condition: .none)
    }
    
    static func service(module: ModulePaths.Service) -> Self {
        .project(target: module.name, path: .relativeToRoot("Service/\(module.name)"), condition: .none)
    }
    
    static func core(module: ModulePaths.Core) -> Self {
        .project(target: module.name, path: .relativeToRoot("Core/\(module.name)"), condition: .none)
    }
    
    static func share(module: ModulePaths.Share) -> Self {
        .project(target: module.name, path: .relativeToRoot("Share/\(module.name)"), condition: .none)
    }
}

extension TargetDependency.SPM {
    
    //MARK: Rx
    static let rxSwift: TargetDependency = .external(name: "RxSwift", condition: .none)
    static let rxCocoa: TargetDependency = .external(name: "RxCocoa", condition: .none)
    static let reactorKit: TargetDependency = .external(name: "ReactorKit", condition: .none)
    static let rxDataSources: TargetDependency = .external(name: "RxDataSources", condition: .none)
    static let swinject: TargetDependency = .external(name: "Swinject", condition: .none)
    
    //MARK: DesignSystems
    static let snapKit: TargetDependency = .external(name: "snapKit", condition: .none)
    static let then: TargetDependency = .external(name: "Then", condition: .none)
    
    //MARK: Network
    static let alamofire: TargetDependency = .external(name: "Alamofire", condition: .none)
    
    //MARK: DI
}
