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
            "CFBundleDisplayName": .string("wespot"),
            "UIUserInterfaceStyle": .string("Light"),
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
            "LSApplicationQueriesSchemes": [
                "kakaokompassauth",
                "kakaolink",
                "kakaoplus"
            ],
            "KAKAO_NATIVE_APP_KEY": .string("$(KAKAO_NATIVE_APP_KEY)"),
            "CFBundleURLTypes": .array([
                .dictionary([
                    "CFBundleTypeRole": .string("Editor"),
                    "CFBundleURLSchemes": .array([
                        .string("kakao$(KAKAO_NATIVE_APP_KEY)")
                    ])
                ])
            ]),
            "NSAppTransportSecurity": .dictionary([
                "NSAllowsArbitraryLoads": .boolean(false)
            ])
        ]
        
        return InfoPlist.extendingDefault(with: basePlist)
    }
}
