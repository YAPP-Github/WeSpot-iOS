//
//  VoteClassMateResponseDTO.swift
//  VoteService
//
//  Created by Kim dohyun on 8/21/24.
//

import Foundation

import VoteDomain


public struct VoteClassMateResponseDTO: Decodable {
    public let response: [VoteClassMateUserResponseDTO]
    
    private enum CodingKeys: String, CodingKey {
        case response = "users"
    }
}

extension VoteClassMateResponseDTO {
    public struct VoteClassMateUserResponseDTO: Decodable {
        public let id: Int
        public let name: String
        public let gender: String
        public let schoolName: String
        public let schoolId: Int
        public let grade: Int
        public let classNumber: Int
        public let profile: VoteClassMateUserProfileResponseDTO
        
    }
}


extension VoteClassMateResponseDTO.VoteClassMateUserResponseDTO {
    public struct VoteClassMateUserProfileResponseDTO: Decodable {
        public let backgroundColor: String
        public let iconUrl: String
        
    }
}

extension VoteClassMateResponseDTO {
    func toDomain() -> VoteClassMatesEntity {
        return .init(user: response.map { $0.toDomain() })
    }
}


extension VoteClassMateResponseDTO.VoteClassMateUserResponseDTO {
    func toDomain() -> VoteClassMateUserEntity {
        return .init(
            id: id,
            name: name,
            gender: gender,
            schoolName: schoolName,
            schoolId: schoolId,
            grade: grade,
            classNumber: classNumber,
            profile: profile.toDomain()
        )
    }
}

extension VoteClassMateResponseDTO.VoteClassMateUserResponseDTO.VoteClassMateUserProfileResponseDTO {
    
    func toDomain() -> VoteClassMateUserProfileEntity {
        return .init(backgroundColor: backgroundColor, iconUrl: URL(string: iconUrl) ?? URL(fileURLWithPath: ""))
    }
}
