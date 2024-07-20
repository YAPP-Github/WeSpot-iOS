//
//  project.swift
//  ProjectDescriptionHelpers
//
//  Created by eunseou on 7/20/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let loginFeature = Project.makeProject(
    module: .feature(.MessageFeature),
    targets: [
        .feature(module: .MessageFeature, dependencies: [
            .domain(module: .MessageDomain),
            .shared(module: .ThirdPartyLib),
            .shared(module: .DesignSystem),
            .core(module: .Util)
        ])
    ]
)
