//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by eunseou on 6/11/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let profileDomain = Project.makeProject(
    module: .domain(.ProfileDomain),
    targets: [
        .make(
            module: ModulePaths.Domain.ProfileDomain,
            dependencies: [
                .make(module: ModulePaths.Shared.ThirdPartyLib)
            ]
        )
    ]
)
