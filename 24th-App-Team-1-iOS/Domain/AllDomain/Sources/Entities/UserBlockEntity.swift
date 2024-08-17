//
//  UserBlockEntity.swift
//  AllDomain
//
//  Created by Kim dohyun on 8/16/24.
//

import Foundation


public struct UserBlockEntity {
    public let message: [UserMessageBlockEntity]
    public let lastCursorId: Int
    public let hasNext: Bool
    
    public init(message: [UserMessageBlockEntity], lastCursorId: Int, hasNext: Bool) {
        self.message = message
        self.lastCursorId = lastCursorId
        self.hasNext = hasNext
    }
}


public struct UserMessageBlockEntity {
    public let id: Int
    public let senderName: String
    public let senderProfile: UserMessageProfileEntity
    public let receiverProfile: UserReceiverProfileEntity
    public let content: String
    public let receivedAt: String
    public let isRead: Bool
    public let isBlocked: Bool
    public let isReported: Bool
    
    public init(
        id: Int,
        senderName: String,
        senderProfile: UserMessageProfileEntity,
        receiverProfile: UserReceiverProfileEntity,
        content: String,
        receivedAt: String,
        isRead: Bool,
        isBlocked: Bool,
        isReported: Bool
    ) {
        self.id = id
        self.senderName = senderName
        self.senderProfile = senderProfile
        self.receiverProfile = receiverProfile
        self.content = content
        self.receivedAt = receivedAt
        self.isRead = isRead
        self.isBlocked = isBlocked
        self.isReported = isReported
    }
}

public struct UserMessageProfileEntity {
    public let id: Int
    public let backgroundColor: String
    public let iconUrl: URL 
    
    public init(
        id: Int,
        backgroundColor: String,
        iconUrl: URL
    ) {
        self.id = id
        self.backgroundColor = backgroundColor
        self.iconUrl = iconUrl
    }
}

public struct UserReceiverProfileEntity {
    public let id: Int
    public let name: String
    public let gender: String
    public let introduction: String
    public let schoolName: String
    public let grade: Int
    public let classNumber: Int
    public let profile: UserReceiverProfileItemEntity
    
    public init(
        id: Int,
        name: String,
        gender: String,
        introduction: String,
        schoolName: String,
        grade: Int,
        classNumber: Int,
        profile: UserReceiverProfileItemEntity
    ) {
        self.id = id
        self.name = name
        self.gender = gender
        self.introduction = introduction
        self.schoolName = schoolName
        self.grade = grade
        self.classNumber = classNumber
        self.profile = profile
    }
}


public struct UserReceiverProfileItemEntity {
    public let backgroundColor: String
    public let iconUrl: URL
    
    public init(backgroundColor: String, iconUrl: URL) {
        self.backgroundColor = backgroundColor
        self.iconUrl = iconUrl
    }
}

