//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by Kim dohyun on 8/11/24.
//

import ProjectDescription
import ProjectDescriptionHelpers


let allFeature = Project.makeProject(
    module: .feature(.AllFeature),
    targets: [
        .feature(
            module: .AllFeature,
            dependencies: [
                .core(module: .Util),
                .domain(module: .CommonDomain),
                .shared(module: .ThirdPartyLib),
                .shared(module: .DesignSystem)
            ])
    ]
)
