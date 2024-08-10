//
//  VoteReceiveResponseDTO.swift
//  VoteService
//
//  Created by Kim dohyun on 8/7/24.
//

import Foundation

import VoteDomain


public struct VoteReceiveResponseDTO: Decodable {
    public let response: [VoteReceiveItemResponseDTO]
    public let isLastPage: Bool
    public let lastCursorId: Int
    
    private enum CodingKeys: String, CodingKey {
        case response = "voteData"
        case isLastPage = "hasNext"
        case lastCursorId
    }
}

extension VoteReceiveResponseDTO {
    
    public struct VoteReceiveItemResponseDTO: Decodable {
        public let voteId: Int
        public let date: String
        public let receiveResponse: [VoteReceiveVoteOptionResponseDTO]
        
        private enum CodingKeys: String, CodingKey {
            case voteId
            case date
            case receiveResponse = "receivedVoteResults"
        }
    }
}


extension VoteReceiveResponseDTO.VoteReceiveItemResponseDTO {
    public struct VoteReceiveVoteOptionResponseDTO: Decodable {
        public let voteOption: VoteReceiveContentResponseDTO
        public let voteCount: Int
        public let isNew: Bool
    }
}

extension VoteReceiveResponseDTO.VoteReceiveItemResponseDTO.VoteReceiveVoteOptionResponseDTO {
    public struct VoteReceiveContentResponseDTO: Decodable {
        public let id: Int
        public let content: String
    }
}



extension VoteReceiveResponseDTO {
    func toDomain() -> VoteRecevieEntity {
        return .init(
            response: response.map { $0.toDomain() },
            isLastPage: isLastPage,
            lastCursorId: lastCursorId
        )
    }
}

extension VoteReceiveResponseDTO.VoteReceiveItemResponseDTO {
    func toDomain() -> VoteReceiveItemEntity {
        return .init(
            voteId: voteId,
            date: date,
            receiveResponse: receiveResponse.map { $0.toDomain() }
        )
    }
}


extension VoteReceiveResponseDTO.VoteReceiveItemResponseDTO.VoteReceiveVoteOptionResponseDTO {
    func toDomain() -> VoteReceiveResponseEntity {
        return .init(
            voteOption: voteOption.toDomain(),
            voteCount: voteCount,
            isNew: isNew
        )
    }
}

extension VoteReceiveResponseDTO.VoteReceiveItemResponseDTO.VoteReceiveVoteOptionResponseDTO.VoteReceiveContentResponseDTO {
    func toDomain() -> VoteReceiveOptionsEntity {
        return .init(
            id: id,
            content: content
        )
    }
}
