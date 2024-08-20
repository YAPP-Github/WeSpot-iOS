//
//  NotificationRequestDTO.swift
//  NotificationService
//
//  Created by Kim dohyun on 8/19/24.
//

import Foundation


public struct NotificationRequestDTO: Encodable {
    public let cursorId: Int
    
    public init(cursorId: Int) {
        self.cursorId = cursorId
    }
}
