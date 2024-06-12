//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by eunseou on 6/12/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .makeProject(
        module: .core(.Extensions),
        targets: [
            .makeTarget(
                module: ModulePaths.Core.Extensions,
                dependencies: [
                    .makeDependency(module: ModulePaths.Shared.ThirdPartyLib)
                ])
        ]
    )
