//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by Kim dohyun on 6/12/24.
//

import ProjectDescription
import ProjectDescriptionHelpers


let project = Project.makeProject(
    module: .core(.Util),
    targets: [
        .core(module: .Util, dependencies: [
            .shared(module: .ThirdPartyLib)
        ])
    ]
)
