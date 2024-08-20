//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by Kim dohyun on 8/19/24.
//

import ProjectDescription
import ProjectDescriptionHelpers


let notificationFeature = Project.makeProject(
    module: .feature(.NotificationFeature),
    targets: [
        .feature(module: .NotificationFeature, dependencies: [
            .core(module: .Util),
            .domain(module: .NotificationDomain),
            .service(module: .NotificationService),
            .shared(module: .ThirdPartyLib),
            .shared(module: .DesignSystem)
        
        ])
    ]
)
