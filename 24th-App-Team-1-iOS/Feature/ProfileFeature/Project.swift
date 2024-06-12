//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by eunseou on 6/11/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeProject(
    module: .feature(.ProfileFeature),
    targets: [
        .makeTarget(
            module: ModulePaths.Feature.ProfileFeature,
            dependencies: [
                .makeDependency(module: ModulePaths.Domain.ProfileDomain),
                .makeDependency(module: ModulePaths.Shared.ThirdPartyLib)
            ]
        )
    ]
)
