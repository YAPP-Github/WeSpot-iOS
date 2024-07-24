//
//  VoteOptionResponseDTO.swift
//  VoteService
//
//  Created by Kim dohyun on 7/22/24.
//

import Foundation

import VoteDomain

public struct VoteResponseDTO: Decodable {
    public let response: [VoteItemResponseDTO]
    
    private enum CodingKeys: String, CodingKey {
        case response = "voteItems"
    }
}

extension VoteResponseDTO {
    public struct VoteItemResponseDTO: Decodable {
        public let userInfo: VoteUserResponseDTO
        public let voteInfo: [VoteOptionsResponseDTO]
        
        private enum CodingKeys: String, CodingKey {
            case userInfo = "user"
            case voteInfo = "voteOptions"
        }
    }
}

extension VoteResponseDTO.VoteItemResponseDTO {
    public struct VoteUserResponseDTO: Decodable {
        public let id: Int
        public let name: String
        public let profileInfo: VoteProfileResponseDTO
        
        private enum CodingKeys: String, CodingKey {
            case id, name
            case profileInfo = "profile"
        }
    }
    
    public struct VoteOptionsResponseDTO: Decodable {
        public let id: Int
        public let content: String
    }
}

extension VoteResponseDTO.VoteItemResponseDTO.VoteUserResponseDTO {
    public struct VoteProfileResponseDTO: Decodable {
        public let backgroundColor: String
        public let iconUrl: String
    }
}

extension VoteResponseDTO {
    func toDomain() -> VoteResponseEntity {
        return .init(response: response.map { $0.toDomain() })
    }
}

extension VoteResponseDTO.VoteItemResponseDTO {
    public func toDomain() -> VoteItemEntity {
        return .init(
            userInfo: userInfo.toDomain(),
            voteInfo: voteInfo.map { $0.toDomain() }
        )
    }
}

extension VoteResponseDTO.VoteItemResponseDTO.VoteUserResponseDTO {
    public func toDomain() -> VoteUserEntity {
        return .init(
            id: id,
            name: name,
            profileInfo: profileInfo.toDomain()
        )
    }
}

extension VoteResponseDTO.VoteItemResponseDTO.VoteOptionsResponseDTO {
    public func toDomain() -> VoteOptionEntity {
        return .init(
            id: id,
            content: content
        )
    }
}

extension VoteResponseDTO.VoteItemResponseDTO.VoteUserResponseDTO.VoteProfileResponseDTO {
    public func toDomain() -> VoteProfileEntity {
        return .init(
            backgroundColor: backgroundColor,
            iconUrl: URL(string: iconUrl) ?? URL(fileURLWithPath: "")
        )
    }
}
