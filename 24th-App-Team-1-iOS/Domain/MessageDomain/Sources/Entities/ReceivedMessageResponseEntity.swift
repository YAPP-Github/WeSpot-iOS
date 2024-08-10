//
//  ReceievedMessageResponseEntity.swift
//  MessageDomain
//
//  Created by eunseou on 8/9/24.
//

import Foundation

public struct ReceivedMessageResponseEntity: Decodable {
    public let messages: [ReceivedMessageEntity]
    public let hasNext: Bool
    
    public init(messages: [ReceivedMessageEntity], hasNext: Bool) {
        self.messages = messages
        self.hasNext = hasNext
    }
}

public struct ReceivedMessageEntity: Decodable {
    public let id: Int
    public let senderName: String
    public let receiver: ReceivedMessageReceiverEntity
    public let content: String
    public let receivedAt: String
    public let isRead: Bool
    public let isBlocked: Bool
    public let isReported: Bool
    public let readAt: String
    
    public init(id: Int, senderName: String, receiver: ReceivedMessageReceiverEntity, content: String, receivedAt: String, isRead: Bool, isBlocked: Bool, isReported: Bool, readAt: String) {
        self.id = id
        self.senderName = senderName
        self.receiver = receiver
        self.content = content
        self.receivedAt = receivedAt
        self.isRead = isRead
        self.isBlocked = isBlocked
        self.isReported = isReported
        self.readAt = readAt
    }
}

public struct ReceivedMessageReceiverEntity: Decodable {
    public let id: Int
    public let name: String
    public let schoolName: String
    public let grade: Int
    public let classNumber: Int
    public let introduction: String
    public let profile: ReceivedMessageProfileEntity
    
    public init(id: Int, name: String, schoolName: String, grade: Int, classNumber: Int, introduction: String, profile: ReceivedMessageProfileEntity) {
        self.id = id
        self.name = name
        self.schoolName = schoolName
        self.grade = grade
        self.classNumber = classNumber
        self.introduction = introduction
        self.profile = profile
    }
}

public struct ReceivedMessageProfileEntity: Decodable {
    public let backgroundColor: String
    public let iconUrl: URL
    
    public init(backgroundColor: String, iconUrl: URL) {
        self.backgroundColor = backgroundColor
        self.iconUrl = iconUrl
    }
}
