//
//  ModulePaths+Templates.swift
//  ProjectDescriptionHelpers
//
//  Created by Kim dohyun on 6/10/24.
//

import Foundation

public protocol ModulePathProtocol: RawRepresentable<String> {
    var name: String { get }
}

public extension ModulePathProtocol {
    var name: String {
        return "\(self.rawValue)"
    }
    var bundleId: String {
        return "com.\(self.rawValue).app"
    }
    
    var appName: String {
        return "wespot"
    }
    
    var appBundleId: String {
        return "com.wespot.app"
    }
}

public enum ModulePaths {
    case app(App)
    case feature(Feature)
    case domain(Domain)
    case service(Service)
    case shared(Shared)
    case core(Core)
}

extension ModulePaths {
    public enum App: String, ModulePathProtocol {
        case app
    }
}

extension ModulePaths {
    public enum Feature: String, ModulePathProtocol {
        case ProfileFeature
        case VoteFeature
    }
}

extension ModulePaths {
    public enum Domain: String, ModulePathProtocol {
        case ProfileDomain
    }
}

extension ModulePaths {
    public enum Service: String, ModulePathProtocol {
        case ProfileService
    }
}

extension ModulePaths {
    public enum Core: String, ModulePathProtocol {
        case Networking
        case Storage
        case Extensions
        case Util
    }
}

extension ModulePaths {
    public enum Shared: String, ModulePathProtocol {
        case ThirdPartyLib
        case DesignSystem
    }
}

