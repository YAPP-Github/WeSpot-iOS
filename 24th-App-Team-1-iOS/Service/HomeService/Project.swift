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
        .makeTarget(
            module: ModulePaths.Service.HomeService,
            dependencies: [
                .makeDependency(module: ModulePaths.Domain.HomeDomain),
                .makeDependency(module: ModulePaths.Core.Networking),
                .makeDependency(module: ModulePaths.Core.Storage),
                .makeDependency(module: ModulePaths.Shared.ThirdPartyLib)
            ]
        )
    ]
)



