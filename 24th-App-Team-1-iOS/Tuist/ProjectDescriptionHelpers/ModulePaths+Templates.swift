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
}

public enum ModulePaths {
    case feature(Feature)
    case domain(Domain)
    case service(Service)
    case shared(Shared)
    case core(Core)
}

public extension ModulePaths {
    enum Feature: String, ModulePathProtocol {
        case HomeFeature
        case ProfileFeature
    }
}

public extension ModulePaths {
    enum Domain: String, ModulePathProtocol {
        case HomeDomain
        case ProfileDomain
    }
}

public extension ModulePaths {
    enum Service: String, ModulePathProtocol {
        case HomeService
        case ProfileService
    }
}

public extension ModulePaths {
    enum Core: String, ModulePathProtocol {
        case Netwroking
        case Storage
        case Extensions
    }
}

public extension ModulePaths {
    enum Shared: String, ModulePathProtocol {
        case ThirdPartyLib
        case DesignSystem
    }
}

