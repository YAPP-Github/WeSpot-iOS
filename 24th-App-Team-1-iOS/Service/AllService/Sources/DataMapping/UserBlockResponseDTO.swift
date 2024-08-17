//
//  UserBlockResponseDTO.swift
//  AllService
//
//  Created by Kim dohyun on 8/16/24.
//

import Foundation

import AllDomain

public struct UserBlockResponseDTO: Decodable {
    public let response: [UserMessageBlockResponseDTO]
    public let lastCursorId: Int
    public let hasNext: Bool
    
    private enum CodingKeys: String, CodingKey {
        case response = "messages"
        case lastCursorId
        case hasNext
    }
}

extension UserBlockResponseDTO {
    public struct UserMessageBlockResponseDTO: Decodable {
        public let id: Int
        public let senderName: String
        public let senderProfile: UserSenderProfileResponseDTO
        public let receiverProfile: UserReceiverProfileResponseDTO
        public let content: String
        public let receivedAt: String
        public let isRead: Bool
        public let isBlocked: Bool
        public let isReported: Bool
        
        private enum CodingKeys: String, CodingKey {
            case id
            case senderName
            case senderProfile
            case receiverProfile = "receiver"
            case content
            case receivedAt
            case isRead
            case isBlocked
            case isReported
        }
    }
}

extension UserBlockResponseDTO.UserMessageBlockResponseDTO {
    public struct UserSenderProfileResponseDTO: Decodable {
        public let id: Int
        public let backgroundColor: String
        public let iconUrl: String
    }
    
    public struct UserReceiverProfileResponseDTO: Decodable {
        public let id: Int
        public let name: String
        public let gender: String
        public let introduction: String
        public let schoolName: String
        public let grade: Int
        public let classNumber: Int
        public let profile: UserReceiverProfileItemResponseDTO
    }
}

extension UserBlockResponseDTO.UserMessageBlockResponseDTO.UserReceiverProfileResponseDTO {
    public struct UserReceiverProfileItemResponseDTO: Decodable {
        public let backgroundColor: String
        public let iconUrl: String
    }
}


extension UserBlockResponseDTO {
    func toDomain() -> UserBlockEntity {
        return .init(message: response.map{ $0.toDomain() }, lastCursorId: lastCursorId, hasNext: hasNext)
    }
}

extension UserBlockResponseDTO.UserMessageBlockResponseDTO {
    func toDomain() -> UserMessageBlockEntity {
        return .init(
            id: id,
            senderName: senderName,
            senderProfile: senderProfile.toDomain(),
            receiverProfile: receiverProfile.toDomain(),
            content: content,
            receivedAt: receivedAt,
            isRead: isRead,
            isBlocked: isBlocked,
            isReported: isReported
        )
    }
}

extension UserBlockResponseDTO.UserMessageBlockResponseDTO.UserSenderProfileResponseDTO {
    func toDomain() -> UserMessageProfileEntity {
        return .init(
            id: id,
            backgroundColor: backgroundColor,
            iconUrl: URL(string: iconUrl) ?? URL(fileURLWithPath: "")
        )
    }
}

extension UserBlockResponseDTO.UserMessageBlockResponseDTO.UserReceiverProfileResponseDTO {
    func toDomain() -> UserReceiverProfileEntity {
        return .init(
            id: id,
            name: name,
            gender: gender,
            introduction: introduction,
            schoolName: schoolName,
            grade: grade,
            classNumber: classNumber,
            profile: profile.toDomain()
        )
    }
}

extension UserBlockResponseDTO.UserMessageBlockResponseDTO.UserReceiverProfileResponseDTO.UserReceiverProfileItemResponseDTO {
    func toDomain() -> UserReceiverProfileItemEntity {
        return .init(backgroundColor: backgroundColor, iconUrl: URL(string: iconUrl) ?? URL(fileURLWithPath: ""))
    }
}
