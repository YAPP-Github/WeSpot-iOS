//
//  Settings+Templates.swift
//  ProjectDescriptionHelpers
//
//  Created by Kim dohyun on 6/27/24.
//

import ProjectDescription


extension Settings {
    public static func makeSettings() -> Self {
        let libraryPaths: SettingsDictionary = [
            "LIBRARY_SEARCH_PATHS": .array([
                "$(TOOLCHAIN_DIR)/usr/lib/swift/$(PLATFORM_NAME)",
                "$(TOOLCHAIN_DIR)/usr/lib/swift-5.0/$(PLATFORM_NAME)",
                "$(SDKROOT)/usr/lib/swift"
            ]),
            "LD_RUNPATH_SEARCH_PATHS": .array([
                "$(inherited)",
                "/usr/lib/swift"
            ])
        ]
        
        return self.settings(base: libraryPaths)
    }
    
    public static func makeAppSettings() -> Self {
        return .settings(configurations: [
            .build(.dev, name: "DEV"),
            .build(.prd, name: "PRD")
        ])
    }
}
