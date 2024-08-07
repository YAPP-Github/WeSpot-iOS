//
//  project.swift
//  ProjectDescriptionHelpers
//
//  Created by eunseou on 7/20/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let messageService = Project.makeProject(
    module: .service(.MessageService),
    targets: [
        .service(module: .MessageService, dependencies: [
            .core(module: .Storage),
            .core(module: .Networking),
            .shared(module: .ThirdPartyLib)
        ])
    ]
)
