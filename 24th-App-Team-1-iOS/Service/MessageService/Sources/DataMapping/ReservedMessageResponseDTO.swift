//
//  MessageResponseDTO.swift
//  MessageService
//
//  Created by eunseou on 8/8/24.
//

import Foundation
import MessageDomain

public struct ReservedMessageResponseDTO: Decodable {
    public let messages: [ReservedMessageItemDTO]
}

// MARK: - Message
public struct ReservedMessageItemDTO: Decodable {
    public let id: Int
    public let senderName: String
    public let receiver: ReservedMessageReceiverDTO
    public let content: String
    public let isRead: Bool
    public let isBlocked: Bool
    public let isReported: Bool
}

// MARK: - Receiver
public struct ReservedMessageReceiverDTO: Decodable {
    public let id: Int
    public let name: String
    public let gender: String
    public let introduction: String
    public let schoolName: String
    public let grade: Int
    public let classNumber: Int
    public let profile: ReservedMessageProfileDTO
}

// MARK: - Profile
public struct ReservedMessageProfileDTO: Decodable {
    public let backgroundColor: String
    public let iconURL: URL
}

extension ReservedMessageResponseDTO {
    func toDomain() -> ReservedMessageResponseEntity {
        return .init(messages: messages.map { $0.toDomain() })
    }
}

extension ReservedMessageItemDTO {
    func toDomain() -> ReservedMessageItemEntity {
        return .init(id: id, senderName: senderName, receiver: receiver.toDomain() , content: content, isRead: isRead, isBlocked: isBlocked, isReported: isReported)
    }
}

extension ReservedMessageReceiverDTO {
    func toDomain() -> ReservedMessageReceiverEntity {
        return .init(id: id, name: name, gender: gender, introduction: introduction, schoolName: schoolName, grade: grade, classNumber: classNumber, profile: profile.toDomain() )
    }
}

extension ReservedMessageProfileDTO {
    func toDomain() -> ReservedMessageProfileEntity {
        return .init(backgroundColor: backgroundColor, iconURL: iconURL)
    }
}
