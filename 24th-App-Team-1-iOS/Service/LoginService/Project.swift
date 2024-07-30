//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by eunseou on 6/11/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let loginService = Project.makeProject(
    module: .service(.LoginService),
    targets: [
        .service(module: .LoginService, dependencies: [
            .core(module: .Storage),
            .core(module: .Networking),
            .shared(module: .ThirdPartyLib)
        ])
    ]
)

