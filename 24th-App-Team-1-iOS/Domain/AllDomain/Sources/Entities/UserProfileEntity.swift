//
//  UserProfileEntity.swift
//  AllDomain
//
//  Created by Kim dohyun on 8/12/24.
//

import Foundation


public struct UserProfileEntity: Identifiable {
    public let id: Int
    public let name: String
    public let gender: String
    public let introduction: String
    public let schoolName: String
    public let grade: Int
    public let classNumber: Int
    public let profile: UserProfileResponseEntity
    
    public init(
        id: Int,
        name: String,
        gender: String,
        introduction: String,
        schoolName: String,
        grade: Int,
        classNumber: Int,
        profile: UserProfileResponseEntity
    ) {
        self.id = id
        self.name = name
        self.gender = gender
        self.introduction = introduction
        self.schoolName = schoolName
        self.grade = grade
        self.classNumber = classNumber
        self.profile = profile
    }
}


public struct UserProfileResponseEntity {
    public let backgroundColor: String
    public let iconUrl: URL
    
    public init(backgroundColor: String, iconUrl: URL) {
        self.backgroundColor = backgroundColor
        self.iconUrl = iconUrl
    }
}
