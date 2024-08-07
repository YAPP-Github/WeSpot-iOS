//
//  UserProfileEntity.swift
//  LoginDomain
//
//  Created by eunseou on 7/31/24.
//

import Foundation

public struct UserProfileImageResponseEntity {
    public let profileImage: String
    public let profileBackground: String
    
    public init(profileImage: String, profileBackground: String) {
        self.profileImage = profileImage
        self.profileBackground = profileBackground
    }
}

public struct UserProfileResponseEntity {
    public let id: Int
    public let name: String
    public let gender: String
    public let introduction: String
    public let schoolName: String
    public let grade: Int
    public let classNumber: Int
    public let profileImages: UserProfileImageResponseEntity
    
    public init(id: Int, name: String, gender: String, introduction: String, schoolName: String, grade: Int, classNumber: Int, profileImages: UserProfileImageResponseEntity) {
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

