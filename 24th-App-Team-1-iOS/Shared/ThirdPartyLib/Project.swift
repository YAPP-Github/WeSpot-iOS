//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by Kim dohyun on 6/12/24.
//

import ProjectDescription

let project = Project
    .makeProject(
        module: .shared(.ThirdPartyLib),
        targets: [
            .make(module: ModulePaths.Shared.ThirdPartyLib, dependencies: [
                .SPM.rxSwift,
                .SPM.rxCocoa,
                .SPM.reactorKit,
                .SPM.rxDataSources,
                .SPM.snapKit,
                .SPM.then,
                .SPM.alamofire,
                .SPM.swinject
            ])
        ]
    )
