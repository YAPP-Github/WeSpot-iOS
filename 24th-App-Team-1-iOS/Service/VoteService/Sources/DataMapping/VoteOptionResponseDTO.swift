//
//  VoteOptionResponseDTO.swift
//  VoteService
//
//  Created by Kim dohyun on 7/22/24.
//

import Foundation

import VoteDomain

public struct VoteItemResponseDTO: Decodable {
    public let userInfo: VoteUserResponseDTO
    public let voteInfo: [VoteOptionsResponseDTO]
}

extension VoteItemResponseDTO {
    public struct VoteUserResponseDTO: Identifiable, Decodable {
        public let id: String
        public let name: String
        public let profileInfo: VoteProfileResponseDTO
        
        private enum CodingKeys: String, CodingKey {
            case id, name
            case profileInfo = "profile"
        }
    }
    
    public struct VoteOptionsResponseDTO: Identifiable, Decodable {
        public let id: String
        public let content: String
    }
}

extension VoteItemResponseDTO.VoteUserResponseDTO {
    public struct VoteProfileResponseDTO: Decodable {
        public let backgroundColor: String
        public let iconUrl: String
    }
}


extension VoteItemResponseDTO {
    public func toDomain() -> VoteItemEntity {
        return .init(
            userInfo: userInfo.toDomain(),
            voteInfo: voteInfo.map { $0.toDomain() }
        )
    }
}

extension VoteItemResponseDTO.VoteUserResponseDTO {
    public func toDomain() -> VoteUserEntity {
        return .init(
            id: id,
            name: name,
            profileInfo: profileInfo.toDomain()
        )
    }
}

extension VoteItemResponseDTO.VoteOptionsResponseDTO {
    public func toDomain() -> VoteOptionEntity {
        return .init(
            id: id,
            content: content
        )
    }
}

extension VoteItemResponseDTO.VoteUserResponseDTO.VoteProfileResponseDTO {
    public func toDomain() -> VoteProfileEntity {
        return .init(
            backgroundColor: backgroundColor,
            iconUrl: URL(string: iconUrl) ?? URL(fileURLWithPath: "")
        )
    }
}
