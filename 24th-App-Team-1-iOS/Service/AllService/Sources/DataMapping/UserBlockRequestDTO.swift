//
//  UserBlockRequestDTO.swift
//  AllService
//
//  Created by Kim dohyun on 8/16/24.
//

import Foundation


public struct UserBlockRequestDTO: Encodable {
    public let cursorId: Int
    
    public init(cursorId: Int) {
        self.cursorId = cursorId
    }
}
