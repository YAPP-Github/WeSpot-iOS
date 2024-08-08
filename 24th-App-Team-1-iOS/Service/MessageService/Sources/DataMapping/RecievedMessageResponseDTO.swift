//
//  MessageResponseDTO.swift
//  MessageService
//
//  Created by eunseou on 8/8/24.
//

import Foundation
import MessageDomain

public struct RecievedMessageResponseDTO: Decodable {
    public let messages: [RecievedMessageItemDTO]
}

// MARK: - Message
public struct RecievedMessageItemDTO: Decodable {
    public let id: Int
    public let senderName: String
    public let receiver: ReceiverDTO
    public let content: String
    public let isRead: Bool
    public let isBlocked: Bool
    public let isReported: Bool
    public let readAt: String
}

// MARK: - Receiver
public struct ReceiverDTO: Decodable {
    public let id: Int
    public let name: String
    public let gender: String
    public let introduction: String
    public let schoolName: String
    public let grade: Int
    public let classNumber: Int
    public let profile: ProfileDTO
}

// MARK: - Profile
public struct ProfileDTO: Decodable {
    public let backgroundColor: String
    public let iconURL: String
}

extension RecievedMessageResponseDTO {
    func toDomain() -> ReservedMessageResponseEntity {
        return .init(messages: messages.map { $0.toDomain() })
    }
}

extension RecievedMessageItemDTO {
    func toDomain() -> ReservedMessageItemEntity {
        return .init(id: id, senderName: senderName, receiver: receiver.toDomain() , content: content, isRead: isRead, isBlocked: isBlocked, isReported: isReported, readAt: readAt)
    }
}

extension ReceiverDTO {
    func toDomain() -> ReceiverEntity {
        return .init(id: id, name: name, gender: gender, introduction: introduction, schoolName: schoolName, grade: grade, classNumber: classNumber, profile: profile.toDomain() )
    }
}

extension ProfileDTO {
    func toDomain() -> ProfileEntity {
        return .init(backgroundColor: backgroundColor, iconURL: iconURL)
    }
}
