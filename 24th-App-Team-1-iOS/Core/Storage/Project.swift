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
        module: .core(.Storage),
        targets: [
            .makeTarget(
                module: ModulePaths.Core.Storage,
                dependencies: [
                    .makeDependency(module: ModulePaths.Shared.ThirdPartyLib)
                ])
        ]
    )
