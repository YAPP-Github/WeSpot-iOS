//
//  NotificationEntity.swift
//  NotificationDomain
//
//  Created by Kim dohyun on 8/19/24.
//

import Foundation

public enum NotificationType: String {
    case vote = "VOTE"
    case voteResults = "VoteResults"
    case voteRecevied = "VOTE_RECEIVED"
    case none
}

public struct NotificationEntity {
    public let notifications: [NotificationItemEntity]
    public let lastCursorId: Int
    public let hasNext: Bool
    
    public init(notifications: [NotificationItemEntity], lastCursorId: Int, hasNext: Bool) {
        self.notifications = notifications
        self.lastCursorId = lastCursorId
        self.hasNext = hasNext
    }
}

public struct NotificationItemEntity: Identifiable {
    public let id: Int
    public let type: NotificationType
    public let date: String
    public let targetId: Int
    public let content: String
    public let isNew: Bool
    public let isEnable: Bool
    public let createdAt: String
    
    public init(id: Int, type: NotificationType, date: String, targetId: Int, content: String, isNew: Bool, isEnable: Bool, createdAt: String) {
        self.id = id
        self.type = type
        self.date = date
        self.targetId = targetId
        self.content = content
        self.isNew = isNew
        self.isEnable = isEnable
        self.createdAt = createdAt
    }
}
