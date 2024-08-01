//
//  Bundle+Extensions.swift
//  Extensions
//
//  Created by eunseou on 8/2/24.
//

import Foundation

public extension Bundle {
    var kakaoNativeAppKey: String {
        return infoDictionary?["KAKAO_NATIVE_APP_KEY"] as? String ?? ""
    }
}
