//
//  VoteIndividualResponseDTO.swift
//  VoteService
//
//  Created by Kim dohyun on 8/10/24.
//

import Foundation

import VoteDomain


public struct VoteIndividualResponseDTO: Decodable {
    public let response: VoteIndividualItemResponseDTO
    
    private enum CodingKeys: String, CodingKey {
        case response = "voteResult"
    }
}

extension VoteIndividualResponseDTO {
    public struct VoteIndividualItemResponseDTO: Decodable {
        public let voteOption: VoteIndividualOptionResponseDTO
        public let user: VoteIndividualUserResponseDTO
        public let rate: Int
        public let voteCount: Int
    }
}

extension VoteIndividualResponseDTO.VoteIndividualItemResponseDTO {
    public struct VoteIndividualOptionResponseDTO: Decodable {
        public let id: Int
        public let content: String
    }
    
    public struct VoteIndividualUserResponseDTO: Decodable {
        public let id: Int
        public let name: String
        public let introduction: String
        public let profile: VoteIndividualProfileResponseDTO
    }
}

extension VoteIndividualResponseDTO.VoteIndividualItemResponseDTO.VoteIndividualUserResponseDTO {
    public struct VoteIndividualProfileResponseDTO: Decodable {
        public let backgroundColor: String
        public let iconUrl: String
    }
}


extension VoteIndividualResponseDTO {
    
    func toDomain() -> VoteIndividualEntity {
        return .init(response: response.toDomain())
    }
}

extension VoteIndividualResponseDTO.VoteIndividualItemResponseDTO {
    func toDomain() -> VoteIndividualResponseEntity {
        return .init(
            voteOption: voteOption.toDomain(),
            user: user.toDomain(),
            rate: rate,
            voteCount: voteCount
        )
    }
}

extension VoteIndividualResponseDTO.VoteIndividualItemResponseDTO.VoteIndividualOptionResponseDTO {
    func toDomain() -> VoteIndividualOptionEntity {
        return .init(
            id: id,
            content: content
        )
    }
}

extension VoteIndividualResponseDTO.VoteIndividualItemResponseDTO.VoteIndividualUserResponseDTO {
    func toDomain() -> VoteIndividualUserEntity {
        return .init(
            id: id,
            name: name,
            introduction: introduction,
            profile: profile.toDomain()
        )
    }
}

extension VoteIndividualResponseDTO.VoteIndividualItemResponseDTO.VoteIndividualUserResponseDTO.VoteIndividualProfileResponseDTO {
    func toDomain() -> VoteIndividualProfileEntity {
        return .init(
            backgroundColor: backgroundColor,
            iconUrl: URL(string: iconUrl) ?? URL(fileURLWithPath: "")
        )
    }
}
