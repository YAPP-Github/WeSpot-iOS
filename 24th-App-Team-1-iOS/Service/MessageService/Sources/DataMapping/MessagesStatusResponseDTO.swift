//
//  MessagesStatusResponseDTO.swift
//  MessageService
//
//  Created by eunseou on 8/9/24.
//

import Foundation
import MessageDomain

public struct MessagesStatusResponseDTO: Decodable {
    public let isSendAllowed: Bool
    public let remainingMessages: Int
}

extension MessagesStatusResponseDTO {
    func toDomain() -> MessageStatusResponseEntity {
        return .init(isSendAllowed: isSendAllowed, remainingMessages: remainingMessages)
    }
}
