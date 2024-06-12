import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .makeProject(
        module: .app(.app),
        targets: [
            .make(module: ModulePaths.App.app, dependencies: [
                .make(module: ModulePaths.Feature.HomeFeature),
                .make(module: ModulePaths.Feature.ProfileFeature)
            ])
        ]
    )

