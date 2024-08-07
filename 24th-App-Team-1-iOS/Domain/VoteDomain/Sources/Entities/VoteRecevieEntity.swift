//
//  VoteRecevieEntity.swift
//  VoteDomain
//
//  Created by Kim dohyun on 8/7/24.
//

import Foundation

public struct VoteRecevieEntity {
    public let response: [VoteReceiveItemEntity]
    public let isLastPage: Bool
    
    public init(response: [VoteReceiveItemEntity], isLastPage: Bool) {
        self.response = response
        self.isLastPage = isLastPage
    }
}

public struct VoteReceiveItemEntity {
    public let date: String
    public let receiveResponse: [VoteReceiveResponseEntity]
    
    public init(
        date: String,
        receiveResponse: [VoteReceiveResponseEntity]
    ) {
        self.date = date
        self.receiveResponse = receiveResponse
    }
}

public struct VoteReceiveResponseEntity {
    public let voteOption: VoteReceiveOptionsEntity
    public let voteCount: Int
    public let isNew: Bool
    
    public init(
        voteOption: VoteReceiveOptionsEntity,
        voteCount: Int,
        isNew: Bool
    ) {
        self.voteOption = voteOption
        self.voteCount = voteCount
        self.isNew = isNew
    }
}

public struct VoteReceiveOptionsEntity: Identifiable {
    public let id: Int
    public let content: String
    
    public init(id: Int, content: String) {
        self.id = id
        self.content = content
    }
}


