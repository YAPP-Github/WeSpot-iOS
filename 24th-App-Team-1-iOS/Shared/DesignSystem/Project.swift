//
//  Project.swift
//  DesignSystemManifests
//
//  Created by Kim dohyun on 6/12/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeProject(
    module: .shared(.DesignSystem),
    targets: [
        .share(module: .DesignSystem, dependencies: [
            .shared(module: .ThirdPartyLib),
            .core(module: .Extensions)
        ])
    ]
)
