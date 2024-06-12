//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by Kim dohyun on 6/11/24.
//

import ProjectDescription
import ProjectDescriptionHelpers


let project = Project.makeProject(
    module: .feature(.HomeFeature),
    targets: [
        .make(
            module: ModulePaths.Feature.HomeFeature,
            dependencies: [
                .make(module: ModulePaths.Domain.HomeDomain),
                .make(module: ModulePaths.Shared.ThirdPartyLib)
            ]
        )
    ]
)


