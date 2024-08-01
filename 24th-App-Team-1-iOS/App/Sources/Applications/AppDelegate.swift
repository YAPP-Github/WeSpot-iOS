//
//  AppDelegate.swift
//  wespot
//
//  Created by Kim dohyun on 6/27/24.
//

import UIKit
import Storage

import RxKakaoSDKAuth
import KakaoSDKAuth
import RxKakaoSDKCommon

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var apnsToken: String?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        let nativeAppKey = Bundle.main.infoDictionary?["KAKAO_NATIVE_APP_KEY"] ?? ""
        
        RxKakaoSDK.initSDK(appKey: nativeAppKey as! String)
        
        // APNs 등록 요청
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            guard granted else { return }
            DispatchQueue.main.async {
                application.registerForRemoteNotifications()
            }
        }
        
        return true
    }
    
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // 디바이스 토큰을 문자열로 변환
        let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
        let token = tokenParts.joined()
        apnsToken = token
        
        APNsTokenManager.shared.token = token
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register: \(error)")
    }
    
    // kakao login
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        if (AuthApi.isKakaoTalkLoginUrl(url)) {
            return AuthController.rx.handleOpenUrl(url: url)
        }
        
        return false
    }
}
