//
//  UserDefaultsManager.swift
//  Util
//
//  Created by eunseou on 7/30/24.
//

import Foundation

public struct UserProfileImage: Codable {
    var profileImage: String
    var profileBackground: String
    
    public init(profileImage: String = "", profileBackground: String = "") {
        self.profileImage = profileImage
        self.profileBackground = profileBackground
    }
}

public struct UserProfile: Codable {
    var id: Int
    var name: String
    var gender: String
    var introduction: String
    var schoolName: String
    var grade: Int
    var classNumber: Int
    var profileImages: UserProfileImage
    
    public init(id: Int = 0, name: String = "", gender: String = "", introduction: String = "", schoolName: String = "", grade: Int = 0, classNumber: Int = 0, profileImages: UserProfileImage = UserProfileImage()) {
        self.id = id
        self.name = name
        self.gender = gender
        self.introduction = introduction
        self.schoolName = schoolName
        self.grade = grade
        self.classNumber = classNumber
        self.profileImages = profileImages
    }
}


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
    
    @UserDefaultsWrapper (key: Key.refreshToken.rawValue, defaultValue: "")
        public var refreshToken: String
    
    @UserDefaultsWrapper(key: Key.userProfile.rawValue, defaultValue: UserProfile())
        public var userProfile: UserProfile
}
