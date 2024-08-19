//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by Kim dohyun on 8/19/24.
//

import ProjectDescription
import ProjectDescriptionHelpers


let notificationService = Project.makeProject(
    module: .service(.NotificationService),
    targets: [
        .service(module: .NotificationService, dependencies: [
            .core(module: .Networking),
            .shared(module: .ThirdPartyLib)
        ])
    ]
)

