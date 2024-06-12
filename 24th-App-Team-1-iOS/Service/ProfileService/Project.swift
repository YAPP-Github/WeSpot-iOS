//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by eunseou on 6/11/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let profileService = Project.makeProject(
    module: .service(.ProfileService),
    targets: [
        .makeTarget(module: ModulePaths.Service.ProfileService, dependencies: [
            .makeDependency(module: ModulePaths.Domain.ProfileDomain),
            .makeDependency(module: ModulePaths.Shared.ThirdPartyLib),
            .makeDependency(module: ModulePaths.Core.Storage),
            .makeDependency(module: ModulePaths.Core.Networking)
            ]
        )
    ]
)
