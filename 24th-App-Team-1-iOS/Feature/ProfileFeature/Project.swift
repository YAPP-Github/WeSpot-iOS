//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by eunseou on 6/11/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let profileFeature = Project.makeProject(
    module: .feature(.ProfileFeature),
    targets: [
        .feature(
            module: .ProfileFeature,
            dependencies: [.domain(module: .ProfileDomain),
                           .shared(module: .ThirdPartyLib)
            ])
    ]
)
