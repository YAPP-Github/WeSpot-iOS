//
//  VoteSentEntity.swift
//  VoteDomain
//
//  Created by Kim dohyun on 8/7/24.
//

import Foundation

public struct VoteSentEntity {
    public let response: [VoteSentItemEntity]
    public let isLastPage: Bool
    
    public init(response: [VoteSentItemEntity], isLastPage: Bool) {
        self.response = response
        self.isLastPage = isLastPage
    }
}


public struct VoteSentItemEntity {
    public let voteId: Int
    public let date: String
    public let sentResponse: [VoteSentResponseEntity]
    
    public init(
        voteId: Int,
        date: String,
        sentResponse: [VoteSentResponseEntity]
    ) {
        self.voteId = voteId
        self.date = date
        self.sentResponse = sentResponse
    }
}


public struct VoteSentResponseEntity {
    public let voteContent: VoteSentContentResponseEntity
    
    public init(voteContent: VoteSentContentResponseEntity) {
        self.voteContent = voteContent
    }
}


public struct VoteSentContentResponseEntity {
    public let voteOption: VoteSentContentItemResponseEntity
    public let voteUser: VoteSentUserResponseEntity
    public init(voteOption: VoteSentContentItemResponseEntity, voteUser: VoteSentUserResponseEntity) {
        self.voteOption = voteOption
        self.voteUser = voteUser
    }
}

public struct VoteSentContentItemResponseEntity: Identifiable {
    public let id: Int
    public let content: String
    
    public init(id: Int, content: String) {
        self.id = id
        self.content = content
    }
}

public struct VoteSentUserResponseEntity: Identifiable {
    public let id: Int
    public let name: String
    public let introduction: String
    public let profile: VoteSentProfileResponseEntity
    
    public init(
        id: Int,
        name: String,
        introduction: String,
        profile: VoteSentProfileResponseEntity
    ) {
        self.id = id
        self.name = name
        self.introduction = introduction
        self.profile = profile
    }
}

public struct VoteSentProfileResponseEntity {
    public let backgroundColor: String
    public let iconUrl: URL
    
    public init(backgroundColor: String, iconUrl: URL) {
        self.backgroundColor = backgroundColor
        self.iconUrl = iconUrl
    }
}
