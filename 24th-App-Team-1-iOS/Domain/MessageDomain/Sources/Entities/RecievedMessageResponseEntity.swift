//
//  RecievedMessageResponseEntity.swift
//  MessageDomain
//
//  Created by eunseou on 8/8/24.
//

import Foundation

public struct RecievedMessageResponseEntity {
    public let messages: [RecievedMessageItemEntity]
    
    public init(messages: [RecievedMessageItemEntity]) {
        self.messages = messages
    }
}

// MARK: - Message
public struct RecievedMessageItemEntity {
    public let id: Int
    public let senderName: String
    public let receiver: ReceiverEntity
    public let content: String
    public let isRead: Bool
    public let isBlocked: Bool
    public let isReported: Bool
    public let readAt: String
    
    public init(id: Int, senderName: String, receiver: ReceiverEntity, content: String, isRead: Bool, isBlocked: Bool, isReported: Bool, readAt: String) {
        self.id = id
        self.senderName = senderName
        self.receiver = receiver
        self.content = content
        self.isRead = isRead
        self.isBlocked = isBlocked
        self.isReported = isReported
        self.readAt = readAt
    }
}

// MARK: - Receiver
public struct ReceiverEntity {
    public let id: Int
    public let name: String
    public let gender: String
    public let introduction: String
    public let schoolName: String
    public let grade: Int
    public let classNumber: Int
    public let profile: ProfileEntity
    
    public init(id: Int, name: String, gender: String, introduction: String, schoolName: String, grade: Int, classNumber: Int, profile: ProfileEntity) {
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
public struct ProfileEntity {
    public let backgroundColor: String
    public let iconURL: String
    
    public init(backgroundColor: String, iconURL: String) {
        self.backgroundColor = backgroundColor
        self.iconURL = iconURL
    }
}
