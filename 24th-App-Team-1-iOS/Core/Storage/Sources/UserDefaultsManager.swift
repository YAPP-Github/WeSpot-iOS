//
//  UserDefaultsManager.swift
//  Util
//
//  Created by eunseou on 7/30/24.
//

import Foundation
import LoginService

public class UserDefaultsManager {
    
    public static let shared = UserDefaultsManager()
    
    private init() {}
    
    enum Key: String {
        case isAccessed // 앱에 처음 접근했는지 확인(Bool)
        case accessToken
        case refreshToken
        case userProfile
    }
    
    @UserDefaultsWrapper(key: Key.isAccessed.rawValue, defaultValue: false)
       public var isAccessed: Bool
    
    @UserDefaultsWrapper (key: Key.accessToken.rawValue, defaultValue: "")
        public var accessToken: String
    
    @UserDefaultsWrapper(key: Key.refreshToken.rawValue, defaultValue: "")
        public var refreshToken: String
    
    @UserDefaultsWrapper(key: Key.userProfile.rawValue, defaultValue: UserProfileResponseDTO(id: 0, name: "", gender: "", introduction: "", schoolName: "", grade: 0, classNumber: 0, profileImages: UserProfileImageResponseDTO(profileImage: "", profileBackground: "")))
        public var userProfile: UserProfileResponseDTO
    
}
