import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .makeProject(
        module: .app(.app),
        targets: [
            .feature(module: .HomeFeature, dependencies: []),
            .feature(module: .ProfileFeature, dependencies: [])
        ]
    )

