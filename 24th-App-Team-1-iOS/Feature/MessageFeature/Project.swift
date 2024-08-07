//
//  project.swift
//  ProjectDescriptionHelpers
//
//  Created by eunseou on 7/20/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let messageFeature = Project.makeProject(
    module: .feature(.MessageFeature),
    targets: [
        .feature(module: .MessageFeature, dependencies: [
            .domain(module: .MessageDomain),
            .service(module: .MessageService),
            .shared(module: .ThirdPartyLib),
            .shared(module: .DesignSystem),
            .core(module: .Util)
        ])
    ]
)
