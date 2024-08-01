//
//  Entitlements.swift
//  ProjectDescriptionHelpers
//
//  Created by eunseou on 7/31/24.
//

import ProjectDescription

extension Entitlements {
    
    public static func appEntitlements() -> Self {
        return .dictionary(
            ["com.apple.developer.applesignin": .array([.string("Default")]),
             "aps-environment": .string("development")]
        )
    }
}

