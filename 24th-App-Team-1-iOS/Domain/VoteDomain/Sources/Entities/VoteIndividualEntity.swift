//
//  VoteIndividualEntity.swift
//  VoteDomain
//
//  Created by Kim dohyun on 8/10/24.
//

import Foundation


public struct VoteIndividualEntity {
    public let response: VoteIndividualResponseEntity
    
    public init(response: VoteIndividualResponseEntity) {
        self.response = response
    }
}


public struct VoteIndividualResponseEntity {
    public let voteOption: VoteIndividualOptionEntity
    public let user: VoteIndividualUserEntity
    public let rate: Int
    public let voteCount: Int
    
    public init(voteOption: VoteIndividualOptionEntity, user: VoteIndividualUserEntity, rate: Int, voteCount: Int) {
        self.voteOption = voteOption
        self.user = user
        self.rate = rate
        self.voteCount = voteCount
    }
}

public struct VoteIndividualOptionEntity: Identifiable {
    public let id: Int
    public let content: String
    
    public init(id: Int, content: String) {
        self.id = id
        self.content = content
    }
}

public struct VoteIndividualUserEntity: Identifiable {
    public let id: Int
    public let name: String
    public let introduction: String
    public let profile: VoteIndividualProfileEntity
    
    public init(id: Int, name: String, introduction: String, profile: VoteIndividualProfileEntity) {
        self.id = id
        self.name = name
        self.introduction = introduction
        self.profile = profile
    }
}

public struct VoteIndividualProfileEntity {
    public let backgroundColor: String
    public let iconUrl: URL
    
    public init(backgroundColor: String, iconUrl: URL) {
        self.backgroundColor = backgroundColor
        self.iconUrl = iconUrl
    }
}
