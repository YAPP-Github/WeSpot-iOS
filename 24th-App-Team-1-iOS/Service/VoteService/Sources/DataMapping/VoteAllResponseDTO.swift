//
//  VoteAllResponseDTO.swift
//  VoteService
//
//  Created by Kim dohyun on 7/30/24.
//

import Foundation

import VoteDomain


public struct VoteAllResponseDTO: Decodable {
    public let response: [VoteAllItemReponseDTO]
    
    private enum CodingKeys: String, CodingKey {
        case response = "voteResults"
    }
}

extension VoteAllResponseDTO {
    public struct VoteAllItemReponseDTO: Decodable {
        public let options: VoteAllOptionsDTO
        public let results: [VoteAllResultsDTO]
        
        private enum CodingKeys: String, CodingKey {
            case options = "voteOption"
            case results
        }
    }
}

extension VoteAllResponseDTO.VoteAllItemReponseDTO {
    public struct VoteAllOptionsDTO: Decodable {
        public let id: Int
        public let content: String
        
    }
    
    public struct VoteAllResultsDTO: Decodable {
        public let user: VoteAllUserResponseDTO
        public let voteCount: Int
    }
}

extension VoteAllResponseDTO.VoteAllItemReponseDTO.VoteAllResultsDTO {
    public struct VoteAllUserResponseDTO: Decodable {
        public let id: Int
        public let name: String
        public let introduction: String
        public let profileInfo: VoteAllProfileResponseDTO
        
        private enum CodingKeys: String, CodingKey {
            case id
            case name, introduction
            case profileInfo = "profile"
        }
    }
}

extension VoteAllResponseDTO.VoteAllItemReponseDTO.VoteAllResultsDTO.VoteAllUserResponseDTO {
    public struct VoteAllProfileResponseDTO: Decodable {
        public let backgroundColor: String
        public let iconUrl: String
    }
}


extension VoteAllResponseDTO {
    func toDomain() -> VoteAllReponseEntity {
        return .init(response: response.map { $0.toDomain()} )
    }
}

extension VoteAllResponseDTO.VoteAllItemReponseDTO {
    func toDomain() -> VoteAllEntity {
        return .init(
            options: options.toDomain(),
            results: results.map { $0.toDomain() }
        )
    }
}


extension VoteAllResponseDTO.VoteAllItemReponseDTO.VoteAllOptionsDTO {
    func toDomain() -> VoteAllOptionsEntity {
        return .init(
            id: id,
            content: content
        )
    }
}

extension VoteAllResponseDTO.VoteAllItemReponseDTO.VoteAllResultsDTO {
    func toDomain() -> VoteAllResultEntity {
        return .init(
            user: user.toDomain(),
            voteCount: voteCount
        )
    }
}

extension VoteAllResponseDTO.VoteAllItemReponseDTO.VoteAllResultsDTO.VoteAllUserResponseDTO {
    func toDomain() -> VoteAllUserEntity {
        return .init(
            id: id,
            name: name,
            introduction: introduction,
            profile: profileInfo.toDomain()
        )
    }
}

extension VoteAllResponseDTO.VoteAllItemReponseDTO.VoteAllResultsDTO.VoteAllUserResponseDTO.VoteAllProfileResponseDTO {
    func toDomain() -> VoteAllProfileEntity {
        return .init(
            backgroundColor: backgroundColor,
            iconUrl: URL(string: iconUrl) ?? URL(fileURLWithPath: "")
        )
    }
}
