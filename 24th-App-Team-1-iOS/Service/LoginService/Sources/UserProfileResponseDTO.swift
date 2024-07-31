//
//  UserProfileResponseDTO.swift
//  LoginService
//
//  Created by eunseou on 7/31/24.
//

import Foundation

import LoginDomain

public struct UserProfileImageResponseDTO: Codable {
    public let profileImage: String
    public let profileBackground: String
    
    public init(profileImage: String, profileBackground: String) {
        self.profileImage = profileImage
        self.profileBackground = profileBackground
    }
}

public struct UserProfileResponseDTO: Codable {
    public let id: Int
    public let name: String
    public let gender: String
    public let introduction: String
    public let schoolName: String
    public let grade: Int
    public let classNumber: Int
    public let profileImages: UserProfileImageResponseDTO
    
    public init(id: Int, name: String, gender: String, introduction: String, schoolName: String, grade: Int, classNumber: Int, profileImages: UserProfileImageResponseDTO) {
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

extension UserProfileImageResponseDTO {
    func toDomain() -> UserProfileImageResponseEntity {
        return UserProfileImageResponseEntity(profileImage: profileImage, profileBackground: profileBackground)
    }
}

extension UserProfileResponseDTO {
    func toDomain() -> UserProfileResponseEntity {
        return .init(id: id, name: name, gender: gender, introduction: introduction, schoolName: schoolName, grade: grade, classNumber: classNumber, profileImages: profileImages.toDomain())
    }
}

