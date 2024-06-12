//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by Kim dohyun on 6/11/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeProject(
    module: .service(.HomeService),
    targets: [
        .make(
            module: ModulePaths.Service.HomeService,
            dependencies: [
                .make(module: ModulePaths.Domain.HomeDomain),
                .make(module: ModulePaths.Core.Netwroking),
                .make(module: ModulePaths.Core.Storage),
                .make(module: ModulePaths.Shared.ThirdPartyLib)
            ]
        )
    ]
)



