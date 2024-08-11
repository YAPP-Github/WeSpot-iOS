//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by Kim dohyun on 8/11/24.
//

import ProjectDescription
import ProjectDescriptionHelpers



let appDomain = Project.makeProject(
    module: .domain(.AllDomain),
    targets: [
        .domain(
            module: .AllDomain,
            dependencies: [
                .shared(module: .ThirdPartyLib)
            ]
        )
    ]
)
