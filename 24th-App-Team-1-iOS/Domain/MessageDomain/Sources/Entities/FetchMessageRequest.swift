//
//  FetchMessageRequest.swift
//  MessageDomain
//
//  Created by eunseou on 8/8/24.
//

import Foundation

public struct MessageRequest: Encodable {
    public let type: String
    public let cursorId: Int
    
    public init(type: String, cursorId: Int) {
        self.type = type
        self.cursorId = cursorId
    }    
}
