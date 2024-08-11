//
//  MessageStatusResponseEntity.swift
//  MessageDomain
//
//  Created by eunseou on 8/9/24.
//

import Foundation

public struct MessageStatusResponseEntity {
    public let isSendAllowed: Bool
    public let remainingMessages: Int
    
    public init(isSendAllowed: Bool, remainingMessages: Int) {
        self.isSendAllowed = isSendAllowed
        self.remainingMessages = remainingMessages
    }
}
