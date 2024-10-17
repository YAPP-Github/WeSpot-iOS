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
            "BASE_URL": .string("https://7b99aa13-6125-4dea-b4e0-2c99c33e5c51.mock.pstmn.io/api/v1")
        ])
    }()
    
    static func makeInfoPlist() -> Self {
        
        
        var basePlist: [String: Plist.Value] = [
            "CFBundleDisplayName": .string("WeSpot"),
            "UIUserInterfaceStyle": .string("Dark"),
            "CFBundleShortVersionString": .string("1.2.1"),
            "CFBundleVersion": .string("1"),
            "UILaunchStoryboardName": .string("LaunchScreen"),
            "UISupportedInterfaceOrientations": .array([.string("UIInterfaceOrientationPortrait")]),
            "UIApplicationSceneManifest": .dictionary([
                "UIApplicationSupportsMultipleScenes": .boolean(false),
                "UISceneConfigurations": .dictionary([
                    "UIWindowSceneSessionRoleApplication" : .array([
                        .dictionary([
                            "UISceneConfigurationName" : .string("Default Configuration"),
                            "UISceneDelegateClassName" : .string("$(PRODUCT_MODULE_NAME).SceneDelegate")
                        ])
                    ])
                ])
            ]),
            "LSApplicationQueriesSchemes": [
                "kakaokompassauth",
                "kakaolink",
                "kakaoplus",
                "instagram-stories"
            ],
            "KAKAO_NATIVE_APP_KEY": .string("$(KAKAO_NATIVE_APP_KEY)"),
            "CFBundleURLTypes": .array([
                .dictionary([
                    "CFBundleTypeRole": .string("Editor"),
                    "CFBundleURLSchemes": .array([
                        .string("$(KAKAO_API_KEY)")
                    ])
                ])
            ]),
            "NSAppTransportSecurity": .dictionary([
                "NSAllowsArbitraryLoads": .boolean(false)
            ]),
            "UIAppFonts": .array([
                .string("Pretendard-Regular.otf"),
                .string("Pretendard-Bold.otf"),
                .string("Pretendard-Medium.otf"),
                .string("Pretendard-SemiBold.otf")
            ]),
            "BASE_URL": .string("https://wespot.kro.kr/api/v1"),
            "NSAppleIDUsageDescription": .string("로그인에 Apple ID를 사용합니다."),
            "aps-environment": .string("development") 
        ]
        
        return InfoPlist.extendingDefault(with: basePlist)
    }
}
