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
        .make(module: ModulePaths.Service.ProfileService, dependencies: [
            .make(module: ModulePaths.Domain.ProfileDomain),
            .make(module: ModulePaths.Shared.ThirdPartyLib),
            .make(module: ModulePaths.Core.Storage),
            .make(module: ModulePaths.Core.Netwroking)
            ]
        )
    ]
)
