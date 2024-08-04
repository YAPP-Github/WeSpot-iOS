//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by eunseou on 8/3/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let loginService = Project.makeProject(
    module: .service(.CommonService),
    targets: [
        .service(module: .CommonService, dependencies: [
            .core(module: .Networking),
            .shared(module: .ThirdPartyLib)
        ])
    ]
)
