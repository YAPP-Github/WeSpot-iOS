//
//  UserProfileResponseDTO.swift
//  CommonService
//
//  Created by 김도현 on 10/16/24.
//

import Foundation

import CommonDomain

public struct UserProfileResponseDTO: Decodable {
    public let id: Int
    public let name: String
    public let gender: String
    public let introduction: String
    public let schoolName: String
    public let grade: Int
    public let classNumber: Int
    public let profile: UserProfileResponseItemDTO
}

extension UserProfileResponseDTO {
    public struct UserProfileResponseItemDTO: Decodable {
        public let backgroundColor: String
        public let iconUrl: String
    }
}


extension UserProfileResponseDTO {
    func toDomain() -> UserProfileEntity {
        return .init(
            id: id,
            name: name,
            gender: gender,
            introduction: introduction,
            schoolName: schoolName,
            grade: grade, classNumber: classNumber, profile: profile.toDomain()
        )
    }
}

extension UserProfileResponseDTO.UserProfileResponseItemDTO {
    func toDomain() -> UserProfileResponseEntity {
        return .init(backgroundColor: backgroundColor, iconUrl: URL(string: iconUrl) ?? URL(fileURLWithPath: ""))
    }
}
