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
        .make(
            module: ModulePaths.Feature.ProfileFeature,
            dependencies: [
                .make(module: ModulePaths.Domain.ProfileDomain),
                .make(module: ModulePaths.Shared.ThirdPartyLib)
            ]
        )
    ]
)
