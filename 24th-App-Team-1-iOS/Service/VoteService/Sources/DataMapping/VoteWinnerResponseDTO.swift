//
//  VoteWinnerResponseDTO.swift
//  VoteService
//
//  Created by Kim dohyun on 7/28/24.
//

import Foundation

import VoteDomain

public struct VoteWinnerResponseDTO: Decodable {
    public let response: [VoteWinnerItemResponseDTO]
    
    private enum CodingKeys: String, CodingKey {
        case response = "voteResults"
    }
}

extension VoteWinnerResponseDTO {
    
    public struct VoteWinnerItemResponseDTO: Decodable {
        public let options: VoteWinnerOptionsDTO
        public let results: [VoteWinnerResultsDTO]
        
        private enum CodingKeys: String, CodingKey {
            case options = "voteOption"
            case results
        }
    }
}

extension VoteWinnerResponseDTO.VoteWinnerItemResponseDTO {
    public struct VoteWinnerOptionsDTO: Decodable {
        public let id: Int
        public let content: String
        
        private enum CodingKeys: String, CodingKey {
            case id
            case content
        }
    }
    
    public struct VoteWinnerResultsDTO: Decodable {
        public let user: VoteWinnerUserResponseDTO
        public let voteCount: Int
    }
}


extension VoteWinnerResponseDTO.VoteWinnerItemResponseDTO.VoteWinnerResultsDTO {
    public struct VoteWinnerUserResponseDTO: Decodable {
        public let id: Int
        public let name: String
        public let introduction: String
        public let profileInfo: VoteWinnerProfileResponseDTO
        
        private enum CodingKeys: String, CodingKey {
            case id
            case name, introduction
            case profileInfo = "profile"
        }
    }
}


extension VoteWinnerResponseDTO.VoteWinnerItemResponseDTO.VoteWinnerResultsDTO.VoteWinnerUserResponseDTO {
    public struct VoteWinnerProfileResponseDTO: Decodable {
        public let backgroundColor: String
        public let iconUrl: String
    }
}

extension VoteWinnerResponseDTO {
    func toDomain() -> VoteWinnerResponseEntity {
        return .init(response: response.map { $0.toDomain() })
    }
}

extension VoteWinnerResponseDTO.VoteWinnerItemResponseDTO {
    func toDomain() -> VoteWinnerEntity {
        return .init(options: options.toDomain(), results: results.map { $0.toDomain() } )
    }
}


extension VoteWinnerResponseDTO.VoteWinnerItemResponseDTO.VoteWinnerOptionsDTO {
    func toDomain() -> VoteWinnerOptionsEntity {
        return .init(id: id, content: content)
    }
}

extension VoteWinnerResponseDTO.VoteWinnerItemResponseDTO.VoteWinnerResultsDTO {
    func toDomain() -> VoteWinnerResultEntity {
        return .init(
            user: user.toDomain(),
            voteCount: voteCount
        )
    }
}

extension VoteWinnerResponseDTO.VoteWinnerItemResponseDTO.VoteWinnerResultsDTO.VoteWinnerUserResponseDTO {
    func toDomain() -> VoteWinnerUserEntity {
        return .init(
            id: id,
            name: name,
            introduction: introduction,
            profile: profileInfo.toDomain()
        )
    }
}

extension VoteWinnerResponseDTO.VoteWinnerItemResponseDTO.VoteWinnerResultsDTO.VoteWinnerUserResponseDTO.VoteWinnerProfileResponseDTO {
    func toDomain() -> VoteWinnerProfileEntity {
        return .init(
            backgroundColor: backgroundColor,
            iconUrl: URL(string: iconUrl) ?? URL(fileURLWithPath: "")
        )
    }
}
