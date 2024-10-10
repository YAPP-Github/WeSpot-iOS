//
//  VoteOptionEntity.swift
//  CommonDomain
//
//  Created by Kim dohyun on 10/10/24.
//

import Foundation

public struct VoteResponseEntity {
    public let response: [VoteItemEntity]
    
    public init(response: [VoteItemEntity]) {
        self.response = response
    }
}

/// 투표 응답 엔티티
public struct VoteItemEntity {
    public let userInfo: VoteUserEntity
    public let voteInfo: [VoteOptionEntity]
    
    public init(userInfo: VoteUserEntity, voteInfo: [VoteOptionEntity]) {
        self.userInfo = userInfo
        self.voteInfo = voteInfo
    }
}

/// 유저 정보 엔티티
public struct VoteUserEntity: Identifiable {
    public let id: Int
    public let name: String
    public let profileInfo: VoteProfileEntity
    
    public init(id: Int, name: String, profileInfo: VoteProfileEntity) {
        self.id = id
        self.name = name
        self.profileInfo = profileInfo
    }
}

/// 유저 프로필 엔티티
public struct VoteProfileEntity {
    public let backgroundColor: String
    public let iconUrl: URL
    
    public init(backgroundColor: String, iconUrl: URL) {
        self.backgroundColor = backgroundColor
        self.iconUrl = iconUrl
    }
}

/// 투표 질문지 엔티티
public struct VoteOptionEntity: Identifiable {
    public let id: Int
    public let content: String
    
    public init(id: Int, content: String) {
        self.id = id
        self.content = content
    }
}
