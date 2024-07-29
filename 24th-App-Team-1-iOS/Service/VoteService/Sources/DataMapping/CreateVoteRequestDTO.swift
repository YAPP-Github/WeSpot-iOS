//
//  CreateVoteRequestDTO.swift
//  VoteService
//
//  Created by Kim dohyun on 7/25/24.
//

import Foundation

public struct CreateVoteRequestDTO: Encodable {
    public let votes: [CreateRequestItemsDTO]
    
    public init(votes: [CreateRequestItemsDTO]) {
        self.votes = votes
    }
}

public struct CreateRequestItemsDTO: Encodable {
    public let userId: Int
    public let voteOptionId: Int
    
    public init(userId: Int, voteOptionId: Int) {
        self.userId = userId
        self.voteOptionId = voteOptionId
    }
}
