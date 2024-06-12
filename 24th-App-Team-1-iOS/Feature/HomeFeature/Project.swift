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
        .makeTarget(
            module: ModulePaths.Feature.HomeFeature,
            dependencies: [
                .makeDependency(module: ModulePaths.Domain.HomeDomain),
                .makeDependency(module: ModulePaths.Shared.ThirdPartyLib)
            ]
        )
    ]
)


