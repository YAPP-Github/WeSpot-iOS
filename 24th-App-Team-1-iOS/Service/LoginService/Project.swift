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
            .domain(module: .LoginDomain),
            .core(module: .Storage),
            .core(module: .Networking),
            .shared(module: .ThirdPartyLib)
        ])
    ]
)

