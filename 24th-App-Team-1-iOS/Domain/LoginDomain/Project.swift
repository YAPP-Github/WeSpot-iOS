//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by eunseou on 6/11/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let loginDomain = Project.makeProject(
    module: .domain(.LoginDomain),
    targets: [
        .domain(module: .LoginDomain, dependencies: [
            .shared(module: .ThirdPartyLib)
        ])
    ]
)
