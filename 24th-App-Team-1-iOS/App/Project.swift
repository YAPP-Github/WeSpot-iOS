import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .makeProject(
        module: .app(.app),
        targets: [
            .makeTarget(module: ModulePaths.App.app, dependencies: [
                .makeDependency(module: ModulePaths.Feature.HomeFeature),
                .makeDependency(module: ModulePaths.Feature.ProfileFeature)
            ])
        ]
    )

