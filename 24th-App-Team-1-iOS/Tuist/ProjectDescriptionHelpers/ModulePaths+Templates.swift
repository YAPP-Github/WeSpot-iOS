//
//  ModulePaths+Templates.swift
//  ProjectDescriptionHelpers
//
//  Created by Kim dohyun on 6/10/24.
//

import Foundation

protocol ModulePathProtocol: RawRepresentable<String> {
    var name: String { get }
}

extension ModulePathProtocol {
    var name: String {
        return "\(self.rawValue)"
    }
    var bundleId: String {
        return "com.\(self.rawValue).app"
    }
}

enum ModulePaths {
    case feature(Feature)
    case domain(Domain)
    case service(Service)
    case shared(Service)
    case core(Core)
}

extension ModulePaths {
    enum Feature: String, ModulePathProtocol {
        case HomeFeature
        case ProfileFeature
    }
}

extension ModulePaths {
    enum Domain: String, ModulePathProtocol {
        case HomeDomain
    }
}

extension ModulePaths {
    enum Service: String, ModulePathProtocol {
        case HomeService
    }
}

extension ModulePaths {
    enum Core: String, ModulePathProtocol {
        case Netwroking
        case Storage
        case Extensions
    }
}

extension ModulePaths {
    enum Share: String, ModulePathProtocol {
        case ThirdPartyLib
        case DesignSystem
    }
}

