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
        .makeTarget(
            module: ModulePaths.Shared.DesignSystem,
            dependencies: [
                .makeDependency(module: ModulePaths.Shared.ThirdPartyLib)
            ]
        )
    ]
)
