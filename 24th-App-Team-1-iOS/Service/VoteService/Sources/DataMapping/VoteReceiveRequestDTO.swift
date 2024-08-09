//
//  VoteReceiveRequestDTO.swift
//  VoteService
//
//  Created by Kim dohyun on 8/9/24.
//

import Foundation


public struct VoteReceiveRequestDTO: Encodable {
    public let cursorId: String
    public let limit: Int
    public init(cursorId: String, limit: Int) {
        self.cursorId = cursorId
        self.limit = limit
    }
}
