//
//  VoteClassMatesEntity.swift
//  VoteDomain
//
//  Created by Kim dohyun on 8/21/24.
//

import Foundation


public struct VoteClassMatesEntity {
    public let user: [VoteClassMateUserEntity]
    
    public init(user: [VoteClassMateUserEntity]) {
        self.user = user
    }
}

public struct VoteClassMateUserEntity: Identifiable {
    public let id: Int
    public let name: String
    public let gender: String
    public let schoolName: String
    public let schoolId: Int
    public let grade: Int
    public let classNumber: Int
    public let profile: VoteClassMateUserProfileEntity
    
    public init(
        id: Int,
        name: String,
        gender: String, 
        schoolName: String,
        schoolId: Int,
        grade: Int,
        classNumber: Int,
        profile: VoteClassMateUserProfileEntity
    ) {
        self.id = id
        self.name = name
        self.gender = gender
        self.schoolName = schoolName
        self.schoolId = schoolId
        self.grade = grade
        self.classNumber = classNumber
        self.profile = profile
    }
}

public struct VoteClassMateUserProfileEntity {
    public let backgroundColor: String
    public let iconUrl: URL
    
    public init(backgroundColor: String, iconUrl: URL) {
        self.backgroundColor = backgroundColor
        self.iconUrl = iconUrl
    }
}
