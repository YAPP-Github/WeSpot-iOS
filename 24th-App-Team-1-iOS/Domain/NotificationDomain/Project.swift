//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by Kim dohyun on 8/19/24.
//

import ProjectDescription
import ProjectDescriptionHelpers


let notificationDomain = Project.makeProject(
    module: .domain(.NotificationDomain),
    targets: [
        .domain(module: .NotificationDomain, dependencies: [
            .shared(module: .ThirdPartyLib)
        
        ])
    ]
)
