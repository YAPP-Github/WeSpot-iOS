//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by Kim dohyun on 6/11/24.
//

import ProjectDescription
import ProjectDescriptionHelpers


let project = Project.makeProject(
    module: .feature(.HomeFeature),
    targets: [
        .feature(module: .HomeFeature, dependencies: [
            .domain(module: .HomeDomain),
            .shared(module: .ThirdPartyLib),
            .core(module: .Util)
        ])
    ]
)


