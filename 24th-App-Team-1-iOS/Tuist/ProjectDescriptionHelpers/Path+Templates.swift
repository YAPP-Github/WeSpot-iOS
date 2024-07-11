//
//  Path+Templates.swift
//  ProjectDescriptionHelpers
//
//  Created by Kim dohyun on 7/10/24.
//

import ProjectDescription


public extension Path {
    static func relativeToXCConfig(_ type: BuildTarget) -> Self {
        return .relativeToRoot("./XCConfig/\(type.rawValue.lowercased()).xcconfig")
    }
}


