//
//  VoteAllEntity.swift
//  VoteDomain
//
//  Created by Kim dohyun on 7/30/24.
//

import Foundation



public struct VoteAllReponseEntity {
    public let response: [VoteAllEntity]
    
    public init(response: [VoteAllEntity]) {
        self.response = response
    }
}


public struct VoteAllEntity {
    public let options: VoteAllOptionsEntity
    public let results: [VoteAllResultEntity]
    
    public init(
        options: VoteAllOptionsEntity,
        results: [VoteAllResultEntity]
    ) {
        self.options = options
        self.results = results
    }
}

public struct VoteAllOptionsEntity {
    public let id: Int
    public let content: String
    
    public init(id: Int, content: String) {
        self.id = id
        self.content = content
    }
}

public struct VoteAllResultEntity {
    public let user: VoteAllUserEntity
    public let voteCount: Int
    
    public init(user: VoteAllUserEntity, voteCount: Int) {
        self.user = user
        self.voteCount = voteCount
    }
}

public struct VoteAllUserEntity {
    public let id: Int
    public let name: String
    public let introduction: String
    public let profile: VoteAllProfileEntity
    
    public init(
        id: Int,
        name: String,
        introduction: String,
        profile: VoteAllProfileEntity
    ) {
        self.id = id
        self.name = name
        self.introduction = introduction
        self.profile = profile
    }
}

public struct VoteAllProfileEntity {
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
