//
//  VoteReceiveRequestQuery.swift
//  VoteDomain
//
//  Created by Kim dohyun on 8/9/24.
//

import Foundation


public struct VoteReceiveRequestQuery {
    public let cursorId: String
    public let limit: Int
    
    public init(cursorId: String, limit: Int = 10) {
        self.cursorId = cursorId
        self.limit = limit
    }
}
