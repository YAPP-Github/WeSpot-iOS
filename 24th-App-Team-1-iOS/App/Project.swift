import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .makeProject(
        module: .app(.app),
        targets: [
            .app(module: .app, dependencies: [
                .feature(module: .LoginFeature),
                .feature(module: .AllFeature),
                .feature(module: .VoteFeature),
                .feature(module: .MessageFeature),
                .feature(module: .NotificationFeature),
                .shared(module: .DesignSystem),
                .SPM.firebaseAnalytics,
                .SPM.firebaseMessaging
            ])
        ]
    )

