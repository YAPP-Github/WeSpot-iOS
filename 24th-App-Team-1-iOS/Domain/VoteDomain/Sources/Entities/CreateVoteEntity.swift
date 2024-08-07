//
//  CreateVoteEntity.swift
//  VoteDomain
//
//  Created by Kim dohyun on 7/25/24.
//

import Foundation


public struct CreateVoteEntity: Equatable {
    public let voteId: Int
    
    public init(voteId: Int) {
        self.voteId = voteId
    }
}
