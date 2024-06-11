//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by eunseou on 6/11/24.
//

import ProjectDescription

let profileService = Project.makeProject(
    module: .service(.ProfileService),
    targets: [
        .service(
            module: .ProfileService,
            dependencies: [.domain(module: .ProfileDomain),
                           .share(module: .ThirdPartyLib),
                           .core(module: .Storage),
                           .core(module: .Netwroking)
            ])
    ]
)
