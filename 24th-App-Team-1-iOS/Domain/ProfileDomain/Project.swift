//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by eunseou on 6/11/24.
//

import ProjectDescription

let profileDomain = Project.makeProject(
    module: .domain(.ProfileDomain),
    targets: [
        .domain(
            module: .ProfileDomain,
            dependencies: [.share(module: .ThirdPartyLib)])
    ]
)
