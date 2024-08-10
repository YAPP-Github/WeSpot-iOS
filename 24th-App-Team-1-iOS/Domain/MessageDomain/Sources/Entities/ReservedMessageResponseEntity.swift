//
//  RecievedMessageResponseEntity.swift
//  MessageDomain
//
//  Created by eunseou on 8/8/24.
//

import Foundation

public struct ReservedMessageResponseEntity {
    public let messages: [ReservedMessageItemEntity]
    
    public init(messages: [ReservedMessageItemEntity]) {
        self.messages = messages
    }
}

// MARK: - Message
public struct ReservedMessageItemEntity {
    public let id: Int
    public let senderName: String
    public let receiver: ReservedMessageReceiverEntity
    public let content: String
    public let isRead: Bool
    public let isBlocked: Bool
    public let isReported: Bool
    
    public init(id: Int, senderName: String, receiver: ReservedMessageReceiverEntity, content: String, isRead: Bool, isBlocked: Bool, isReported: Bool) {
        self.id = id
        self.senderName = senderName
        self.receiver = receiver
        self.content = content
        self.isRead = isRead
        self.isBlocked = isBlocked
        self.isReported = isReported
    }
}

// MARK: - Receiver
public struct ReservedMessageReceiverEntity {
    public let id: Int
    public let name: String
    public let gender: String
    public let introduction: String
    public let schoolName: String
    public let grade: Int
    public let classNumber: Int
    public let profile: ReservedMessageProfileEntity
    
    public init(id: Int, name: String, gender: String, introduction: String, schoolName: String, grade: Int, classNumber: Int, profile: ReservedMessageProfileEntity) {
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

// MARK: - Profile
public struct ReservedMessageProfileEntity {
    public let backgroundColor: String
    public let iconURL: URL
    
    public init(backgroundColor: String, iconURL: URL) {
        self.backgroundColor = backgroundColor
        self.iconURL = iconURL
    }
}
