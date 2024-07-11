//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by eunseou on 6/11/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let loginFeature = Project.makeProject(
    module: .feature(.LoginFeature),
    targets: [
        .feature(module: .LoginFeature, dependencies: [
            .domain(module: .LoginDomain),
            .shared(module: .ThirdPartyLib),
            .shared(module: .DesignSystem),
            .core(module: .Util)
        ])
    ]
)
