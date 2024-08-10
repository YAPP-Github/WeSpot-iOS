//
//  ReceievedMessageResponseDTO.swift
//  MessageService
//
//  Created by eunseou on 8/9/24.
//

import Foundation

import MessageDomain

public struct ReceievedMessageResponseDTO: Decodable {
    public let messages: [ReceievedMessageDTO]
    public let hasNext: Bool
}

public struct ReceievedMessageDTO: Decodable {
    public let id: Int
    public let senderName: String
    public let receiver: ReceievedMessageReceiverDTO
    public let content: String
    public let receivedAt: String
    public let isRead: Bool
    public let isBlocked: Bool
    public let isReported: Bool
    public let readAt: String
}

public struct ReceievedMessageReceiverDTO: Decodable {
    public let id: Int
    public let name: String
    public let schoolName: String
    public let grade: Int
    public let classNumber: Int
    public let introduction: String
    public let profile: ReceievedMessageProfileDTO
}

public struct ReceievedMessageProfileDTO: Decodable {
    public let backgroundColor: String
    public let iconUrl: URL
}

extension ReceievedMessageResponseDTO {
    func toDomain() -> ReceivedMessageResponseEntity {
        return .init(messages: messages.map { $0.toDomain() }, hasNext: hasNext)
    }
}

extension ReceievedMessageDTO {
    func toDomain() -> ReceivedMessageEntity {
        return .init(id: id, senderName: senderName, receiver: receiver.toDomain(), content: content, receivedAt: receivedAt, isRead: isRead, isBlocked: isBlocked, isReported: isReported, readAt: readAt)
    }
}

extension ReceievedMessageReceiverDTO {
    func toDomain() -> ReceivedMessageReceiverEntity {
        return .init(id: id, name: name, schoolName: schoolName, grade: grade, classNumber: classNumber, introduction: introduction, profile: profile.toDomain())
    }
}

extension ReceievedMessageProfileDTO {
    func toDomain() -> ReceivedMessageProfileEntity {
        return .init(backgroundColor: backgroundColor, iconUrl: iconUrl)
    }
}
