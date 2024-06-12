//
//  TargetDependency+Templates.swift
//  ProjectDescriptionHelpers
//
//  Created by Kim dohyun on 6/10/24.
//

import ProjectDescription

extension TargetDependency {
    public struct SPM { }
}

extension TargetDependency {
    /**
     - Parameters:
        - module: ModulePathProtocol 채택한 Type
     - Returns: TargetDependency Type
     */
    public static func makeDependency<M: ModulePathProtocol>(module: M) -> Self {
        if module.name.contains("Feature") {
            return .project(target: module.name, path: .relativeToRoot("Feature/\(module.name)"))
        } else if module.name.contains("Domain") {
            return .project(target: module.name, path: .relativeToRoot("Domain/\(module.name)"))
        } else if module.name.contains("Service") {
            return .project(target: module.name, path: .relativeToRoot("Service/\(module.name)"))
        } else if module.name.contains("Core") {
            return .project(target: module.name, path: .relativeToRoot("Core/\(module.name)"))
        } else {
            return .project(target: module.name, path: .relativeToRoot("Shared/\(module.name)"))
        }
    }
}

extension TargetDependency.SPM {
    //MARK: Rx
    public static let rxSwift: TargetDependency = .external(name: "RxSwift")
    public static let rxCocoa: TargetDependency = .external(name: "RxCocoa")
    public static let reactorKit: TargetDependency = .external(name: "ReactorKit")
    public static let rxDataSources: TargetDependency = .external(name: "RxDataSources")
    
    //MARK: DesignSystems
    public static let snapKit: TargetDependency = .external(name: "snapKit")
    public static let then: TargetDependency = .external(name: "Then")
    
    //MARK: Network
    public static let alamofire: TargetDependency = .external(name: "Alamofire")
    
    //MARK: DI
    public static let swinject: TargetDependency = .external(name: "Swinject")
}
