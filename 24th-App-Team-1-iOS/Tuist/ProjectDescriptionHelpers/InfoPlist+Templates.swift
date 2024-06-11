//
//  InfoPlist+Templates.swift
//  ProjectDescriptionHelpers
//
//  Created by eunseou on 6/11/24.
//

import ProjectDescription

extension InfoPlist {
    
    static func makeInfoPlist() -> Self {
        
        var basePlist: [String: Plist.Value] = [
            "CFBundleShortVersionString": "1.0",
            "CFBundleVersion": "1",
            "UILaunchStoryboardName": "LaunchScreen",
            "UIApplicationSceneManifest": [
                "UIApplicationSupportsMultipleScenes": false,
                "UISceneConfigurations": [
                    "UIWindowSceneSessionRoleApplication": [
                        "UISceneConfigurationName": "Default Configuration",
                        "UISceneDelegateClassName": "$(PRODUCT_MODULE_NAME).SceneDelegate",
                        "UISceneStoryboardFile": "Main"
                    ]
                ]
            ]
        ]
        
        return InfoPlist.extendingDefault(with: basePlist)
    }
}
