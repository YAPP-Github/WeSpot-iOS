//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by Kim dohyun on 8/11/24.
//

import ProjectDescription
import ProjectDescriptionHelpers


let appService = Project.makeProject(
    module: .service(.AlleService),
    targets: [
        .service(
            module: .AlleService,
            dependencies: [
                .core(module: .Networking),
                .shared(module: .ThirdPartyLib)
            ]
        )
    ]
)
