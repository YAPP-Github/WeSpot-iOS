//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by Kim dohyun on 6/11/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeProject(
    module: .service(.HomeService),
    targets: [
        .service(module: .HomeService, dependencies: [
            .domain(module: .HomeDomain),
            .core(module: .Networking),
            .core(module: .Storage),
            .shared(module: .ThirdPartyLib)
        ])
    ]
)



