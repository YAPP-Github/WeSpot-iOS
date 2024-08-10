//
//  FetchMessageRequest.swift
//  MessageDomain
//
//  Created by eunseou on 8/8/24.
//

import Foundation

public enum MessageType: String, Encodable {
    case received = "RECEIVED"
    case sent = "SENT"
}

public struct MessageRequest: Encodable {
    public let type: MessageType
    public let cursorId: Int
    
    public init(type: MessageType, cursorId: Int) {
        self.type = type
        self.cursorId = cursorId
    }    
}
