//
//  VoteWinnerEntity.swift
//  VoteDomain
//
//  Created by Kim dohyun on 7/28/24.
//

import Foundation

public struct VoteWinnerResponseEntity {
    public let response: [VoteWinnerEntity]
    
    public init(response: [VoteWinnerEntity]) {
        self.response = response
    }
}

public struct VoteWinnerEntity {
    public let options: VoteWinnerOptionsEntity
    public let results: [VoteWinnerResultEntity]
    
    public init(options: VoteWinnerOptionsEntity, results: [VoteWinnerResultEntity]) {
        self.options = options
        self.results = results
    }
}

public struct VoteWinnerOptionsEntity {
    public let id: Int
    public let content: String
    
    public init(id: Int, content: String) {
        self.id = id
        self.content = content
    }
}

public struct VoteWinnerResultEntity {
    public let user: VoteWinnerUserEntity
    public let voteCount: Int
    
    public init(user: VoteWinnerUserEntity, voteCount: Int) {
        self.user = user
        self.voteCount = voteCount
    }
}

public struct VoteWinnerUserEntity: Identifiable {
    public let id: Int
    public let name: String
    public let introduction: String
    public let profile: VoteWinnerProfileEntity
    
    public init(
        id: Int,
        name: String,
        introduction: String,
        profile: VoteWinnerProfileEntity
    ) {
        self.id = id
        self.name = name
        self.introduction = introduction
        self.profile = profile
    }
}


public struct VoteWinnerProfileEntity {
    public let backgroundColor: String
    public let iconUrl: URL
    
    public init(
        backgroundColor: String,
        iconUrl: URL
    ) {
        self.backgroundColor = backgroundColor
        self.iconUrl = iconUrl
    }
}
