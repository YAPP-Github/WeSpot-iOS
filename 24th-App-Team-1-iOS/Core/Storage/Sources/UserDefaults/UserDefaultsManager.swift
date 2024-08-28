//
//  UserDefaultsManager.swift
//  Util
//
//  Created by eunseou on 7/30/24.
//

import Foundation
import LoginDomain

public class UserDefaultsManager {
    
    public static let shared = UserDefaultsManager()
    
    private init() {}
    
    enum Key: String {
        case isAccessed // 앱에 처음 접근했는지 확인(Bool)
        case accessToken // access token
        case refreshToken // 재발행 토큰
        case userProfile // 사용자 프로필
        case fcmToken
        case expiredDate
    }
    
    @UserDefaultsWrapper(key: Key.isAccessed.rawValue, defaultValue: false)
       public var isAccessed: Bool?
    
    @UserDefaultsWrapper (key: Key.accessToken.rawValue, defaultValue: "")
        public var accessToken: String?
    
    @UserDefaultsWrapper(key: Key.refreshToken.rawValue, defaultValue: "")
        public var refreshToken: String?
    
    @UserDefaultsWrapper(key: Key.userProfile.rawValue, defaultValue: nil)
        public var userProfile: UserProfileResponseEntity?
    
    @UserDefaultsWrapper(key: Key.expiredDate.rawValue, defaultValue: nil)
        public var expiredDate: Date?
    
    @UserDefaultsWrapper(key: Key.fcmToken.rawValue, defaultValue: "")
        public var fcmToken: String?
}
