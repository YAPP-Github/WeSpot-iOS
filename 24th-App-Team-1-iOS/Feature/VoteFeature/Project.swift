//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by Kim dohyun on 7/11/24.
//

import ProjectDescription
import ProjectDescriptionHelpers


let project = Project.makeProject(
    module: .feature(.VoteFeature),
    targets: [
        .feature(
            module: .VoteFeature,
            dependencies: [
                .core(module: .Util),
                .service(module: .VoteService),
                .domain(module: .VoteDomain),
                .shared(module: .ThirdPartyLib),
                .shared(module: .DesignSystem)
            ]
        )
    ]
)
