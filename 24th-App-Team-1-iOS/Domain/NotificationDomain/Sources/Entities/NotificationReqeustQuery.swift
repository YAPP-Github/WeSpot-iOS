//
//  NotificationReqeustQuery.swift
//  NotificationDomain
//
//  Created by Kim dohyun on 8/19/24.
//

import Foundation


public struct NotificationReqeustQuery {
    
    public let cursorId: Int
    
    public init(cursorId: Int) {
        self.cursorId = cursorId
    }
}
