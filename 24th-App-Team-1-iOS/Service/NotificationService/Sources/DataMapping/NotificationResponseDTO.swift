//
//  NotificationResponseDTO.swift
//  NotificationService
//
//  Created by Kim dohyun on 8/19/24.
//

import Foundation

import NotificationDomain


public struct NotificationResponseDTO: Decodable {
    
    public let notifications: [NotificationItemResponseDTO]
    public let lastCursorId: Int
    public let hasNext: Bool
}


extension NotificationResponseDTO {
    public struct NotificationItemResponseDTO: Decodable {
        public let id: Int
        public let type: String
        public let date: String
        public let targetId: Int
        public let content: String
        public let isNew: Bool
        public let isEnable: Bool
        public let createdAt: String
    }
}


extension NotificationResponseDTO {
    func toDomain() -> NotificationEntity {
        return .init(
            notifications: notifications.map { $0.toDomain() },
            lastCursorId: lastCursorId,
            hasNext: hasNext
        )
    }
}

extension NotificationResponseDTO.NotificationItemResponseDTO {
    func toDomain() -> NotificationItemEntity {
        return .init(
            id: id,
            type: NotificationType(rawValue: type) ?? .none,
            date: date,
            targetId: targetId,
            content: content,
            isNew: isNew,
            isEnable: isEnable,
            createdAt: createdAt
        )
    }
}

