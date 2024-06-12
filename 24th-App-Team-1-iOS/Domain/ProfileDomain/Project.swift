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
        .makeTarget(
            module: ModulePaths.Domain.ProfileDomain,
            dependencies: [
                .makeDependency(module: ModulePaths.Shared.ThirdPartyLib)
            ]
        )
    ]
)
