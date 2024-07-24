//
//  InfoPlist+Templates.swift
//  ProjectDescriptionHelpers
//
//  Created by eunseou on 6/11/24.
//

import ProjectDescription

extension InfoPlist {
    
    public static var `default`: Self = {
        return .extendingDefault(with: [
            "BASE_URL": .string("https://2b0c4a7a-16b4-4b4e-a7c2-5494a7c2f696.mock.pstmn.io/api/v1")
        ])
    }()
    
    static func makeInfoPlist() -> Self {
        
        
        var basePlist: [String: Plist.Value] = [
            "CFBundleDisplayName": .string("wespot"),
            "UIUserInterfaceStyle": .string("Dark"),
            "CFBundleShortVersionString": .string("1.0"),
            "CFBundleVersion": .string("1"),
            "UILaunchStoryboardName": .string("LaunchScreen"),
            "UIApplicationSceneManifest": .dictionary([
                "UIApplicationSupportsMultipleScenes": .boolean(false),
                "UISceneConfigurations": [
                    "UIWindowSceneSessionRoleApplication": .array([
                        .dictionary([
                            "UISceneConfigurationName": .string("Default Configuration"),
                            "UISceneDelegateClassName": .string("$(PRODUCT_MODULE_NAME).SceneDelegate")
                        ])
                    ])
                ]
            ]),
            "UIAppFonts": .array([
                .string("Pretendard-Regular.otf"),
                .string("Pretendard-Bold.otf"),
                .string("Pretendard-Medium.otf"),
                .string("Pretendard-SemiBold.otf")
            ]),
            "BASE_URL": .string("https://2b0c4a7a-16b4-4b4e-a7c2-5494a7c2f696.mock.pstmn.io/api/v1")
        ]
        
        return InfoPlist.extendingDefault(with: basePlist)
    }
}
