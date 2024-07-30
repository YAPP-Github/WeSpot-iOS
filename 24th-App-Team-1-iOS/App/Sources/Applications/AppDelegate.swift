//
//  AppDelegate.swift
//  wespot
//
//  Created by Kim dohyun on 6/27/24.
//

import UIKit

import RxKakaoSDKAuth
import KakaoSDKAuth
import RxKakaoSDKCommon

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        let nativeAppKey = Bundle.main.infoDictionary?["KAKAO_NATIVE_APP_KEY"] ?? ""
        
        RxKakaoSDK.initSDK(appKey: nativeAppKey as! String)
        
        return true
    }
    
    // kakao login
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        if (AuthApi.isKakaoTalkLoginUrl(url)) {
            return AuthController.rx.handleOpenUrl(url: url)
        }
        
        return false
    }
}
