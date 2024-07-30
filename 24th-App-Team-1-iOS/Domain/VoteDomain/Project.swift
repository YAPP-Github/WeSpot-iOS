//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by Kim dohyun on 7/22/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let voteDomain = Project.makeProject(
    module: .domain(.VoteDomain),
    targets: [
        .domain(
            module: .VoteDomain,
            dependencies: [
                .shared(module: .ThirdPartyLib)
            ]
        )
    ]
)
