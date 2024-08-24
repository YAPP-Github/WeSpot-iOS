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
    public static func feature(module: ModulePaths.Feature) -> Self {
        .project(target: module.name, path: .relativeToRoot("Feature/\(module.name)"))
    }
    
    public static func domain(module: ModulePaths.Domain) -> Self {
        .project(target: module.name, path: .relativeToRoot("Domain/\(module.name)"))
    }
    
    public static func service(module: ModulePaths.Service) -> Self {
        .project(target: module.name, path: .relativeToRoot("Service/\(module.name)"))
    }
    
    public static func core(module: ModulePaths.Core) -> Self {
        .project(target: module.name, path: .relativeToRoot("Core/\(module.name)"))
    }
    
    public static func shared(module: ModulePaths.Shared) -> Self {
        .project(target: module.name, path: .relativeToRoot("Shared/\(module.name)"))
    }
}

extension TargetDependency.SPM {
    //MARK: Rx
    public static let rxSwift: TargetDependency = .external(name: "RxSwift")
    public static let rxCocoa: TargetDependency = .external(name: "RxCocoa")
    public static let reactorKit: TargetDependency = .external(name: "ReactorKit")
    public static let rxDataSources: TargetDependency = .external(name: "RxDataSources")
    
    //MARK: DesignSystems
    public static let snapKit: TargetDependency = .external(name: "SnapKit")
    public static let then: TargetDependency = .external(name: "Then")
    public static let lottie: TargetDependency = .external(name: "Lottie")
    
    //MARK: Network
    public static let alamofire: TargetDependency = .external(name: "Alamofire")
    
    //MARK: DI
    public static let swinject: TargetDependency = .external(name: "Swinject")
    
    //MARK: Kakao SDK
    public static let kakaoSDKAuth: TargetDependency = .external(name: "KakaoSDKAuth")
    public static let rxKakaoSDKAuth: TargetDependency = .external(name: "RxKakaoSDKAuth")
    public static let kakaoSDKUser: TargetDependency = .external(name: "KakaoSDKUser")
    public static let rxKakaoSDKUser: TargetDependency = .external(name: "RxKakaoSDKUser")
    
    //MARK: FireBase
    public static let firebaseAnalytics: TargetDependency = .external(name: "FirebaseAnalytics")
    public static let firebaseMessaging: TargetDependency = .external(name: "FirebaseMessaging")
    public static let firebaseCrashlytics: TargetDependency = .external(name: "FirebaseCrashlytics")
    
    //MARK: Cache
    public static let kingfisher: TargetDependency = .external(name: "Kingfisher")
    
    //MARK: KeyChain
    public static let keychain: TargetDependency = .external(name: "KeychainSwift")
}
