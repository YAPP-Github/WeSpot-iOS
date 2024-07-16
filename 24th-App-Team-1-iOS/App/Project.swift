import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .makeProject(
        module: .app(.app),
        targets: [
            .app(module: .app, dependencies: [
                .feature(module: .LoginFeature),
                .feature(module: .ProfileFeature),
                .feature(module: .VoteFeature),
                .shared(module: .DesignSystem)
            ])
        ]
    )

