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
            .core(module: .Networking, dependencies: [
                .shared(module: .ThirdPartyLib),
                .core(module: .Util),
                .core(module: .Storage)
            ])
        ]
    )

