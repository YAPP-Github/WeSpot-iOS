//
//  VoteSentResponseDTO.swift
//  VoteService
//
//  Created by Kim dohyun on 8/7/24.
//

import Foundation

import VoteDomain

public struct VoteSentResponseDTO: Decodable {
    public let response: [VoteSentItemResponseDTO]
    public let isLastPage: Bool
    public let lastCursorId: Int
    
    private enum CodingKeys: String, CodingKey {
        case response = "voteData"
        case isLastPage = "hasNext"
        case lastCursorId
    }
}

extension VoteSentResponseDTO {
    public struct VoteSentItemResponseDTO: Decodable {
        public let voteId: Int
        public let date: String
        public let sentResponse: [VoteSentContentResponseDTO]
        
        private enum CodingKeys: String, CodingKey {
            case voteId
            case date
            case sentResponse = "sentVoteResults"
        }
    }
}

extension VoteSentResponseDTO.VoteSentItemResponseDTO {
    public struct VoteSentContentResponseDTO: Decodable {
        public let voteContent: VoteSentResultsResponseDTO
        
        private enum CodingKeys: String, CodingKey {
            case voteContent = "vote"
        }
    }
}

extension VoteSentResponseDTO.VoteSentItemResponseDTO.VoteSentContentResponseDTO {
    public struct VoteSentResultsResponseDTO: Decodable {
        public let voteOption: VoteSentOptionsContentResponseDTO
        public let voteUser: VoteSentUserResponseDTO
        
        private enum CodingKeys: String, CodingKey {
            case voteOption
            case voteUser = "user"
        }
    }
    
    public struct VoteSentUserResponseDTO: Decodable {
        public let id: Int
        public let name: String
        public let introduction: String
        public let profile: VoteSentUserProfileResponseDTO
    }
}

extension VoteSentResponseDTO.VoteSentItemResponseDTO.VoteSentContentResponseDTO.VoteSentResultsResponseDTO {
    public struct VoteSentOptionsContentResponseDTO: Decodable {
        public let id: Int
        public let content: String
    }
}

extension VoteSentResponseDTO.VoteSentItemResponseDTO.VoteSentContentResponseDTO.VoteSentUserResponseDTO {
    public struct VoteSentUserProfileResponseDTO: Decodable {
        public let backgroundColor: String
        public let iconUrl: String
    }
}






extension VoteSentResponseDTO {
    func toDomain() -> VoteSentEntity {
        return .init(
            response: response.map { $0.toDomain() },
            isLastPage: isLastPage,
            lastCursorId: lastCursorId
        )
    }
}

extension VoteSentResponseDTO.VoteSentItemResponseDTO {
    func toDomain() -> VoteSentItemEntity {
        return .init(voteId: voteId, date: date, sentResponse: sentResponse.map { $0.toDomain() })
    }
}

extension VoteSentResponseDTO.VoteSentItemResponseDTO.VoteSentContentResponseDTO {
    func toDomain() -> VoteSentResponseEntity {
        return .init(voteContent: voteContent.toDomain())
    }
}

extension VoteSentResponseDTO.VoteSentItemResponseDTO.VoteSentContentResponseDTO.VoteSentResultsResponseDTO {
    func toDomain() -> VoteSentContentResponseEntity {
        return .init(
            voteOption: voteOption.toDomain(),
            voteUser: voteUser.toDomain()
        )
    }
}


extension VoteSentResponseDTO.VoteSentItemResponseDTO.VoteSentContentResponseDTO.VoteSentResultsResponseDTO.VoteSentOptionsContentResponseDTO {
    func toDomain() -> VoteSentContentItemResponseEntity {
        return .init(id: id, content: content)
    }
}

extension VoteSentResponseDTO.VoteSentItemResponseDTO.VoteSentContentResponseDTO.VoteSentUserResponseDTO {
    func toDomain() -> VoteSentUserResponseEntity {
        return .init(
            id: id,
            name: name,
            introduction: introduction,
            profile: profile.toDomain()
        )
    }
}

extension VoteSentResponseDTO.VoteSentItemResponseDTO.VoteSentContentResponseDTO.VoteSentUserResponseDTO.VoteSentUserProfileResponseDTO {
    func toDomain() -> VoteSentProfileResponseEntity {
        return .init(
            backgroundColor: backgroundColor,
            iconUrl: URL(string: iconUrl) ?? URL(fileURLWithPath: "")
            )
    }
}
