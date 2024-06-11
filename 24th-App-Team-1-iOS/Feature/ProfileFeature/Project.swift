//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by eunseou on 6/11/24.
//

import ProjectDescription

let profileFeature = Project.makeProject(
    module: .feature(.ProfileFeature),
    targets: [
        .feature(
            module: .ProfileFeature,
            dependencies: [.domain(module: .ProfileDomain),
                           .share(module: .ThirdPartyLib)
            ])
    ]
)
