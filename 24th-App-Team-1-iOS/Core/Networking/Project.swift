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
        module: .core(.Networking),
        targets: [
            .make(
                module: ModulePaths.Core.Networking,
                dependencies: [
                    .make(module: ModulePaths.Shared.ThirdPartyLib)
                ])
        ]
    )

