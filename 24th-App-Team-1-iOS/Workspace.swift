//
//  Workspace.swift
//  Packages
//
//  Created by Kim dohyun on 6/12/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let workspace = Workspace(
    name: "wespot",
    projects: [
        "App/**",
        "Domain/**",
        "Feature/**",
        "Service/**",
        "Core/**",
        "Shared/**"
    ]
)
