//
//  UserBlockRequestQuery.swift
//  AllDomain
//
//  Created by Kim dohyun on 8/16/24.
//

import Foundation


public struct UserBlockRequestQuery {
    public let cursorId: Int
    
    public init(cursorId: Int) {
        self.cursorId = cursorId
    }
}
