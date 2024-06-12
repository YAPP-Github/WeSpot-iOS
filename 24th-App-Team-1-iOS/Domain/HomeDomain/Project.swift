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
        .domain(module: .HomeDomain, dependencies: [
            .shared(module: .ThirdPartyLib)
        ])
    ]
)
