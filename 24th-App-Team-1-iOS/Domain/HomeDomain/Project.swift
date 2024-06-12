//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by Kim dohyun on 6/11/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeProject(
    module: .domain(.HomeDomain),
    targets: [
        .makeTarget(
            module: ModulePaths.Domain.HomeDomain,
            dependencies: [
                .makeDependency(module: ModulePaths.Shared.ThirdPartyLib)
            ]
        )
    ]
)
