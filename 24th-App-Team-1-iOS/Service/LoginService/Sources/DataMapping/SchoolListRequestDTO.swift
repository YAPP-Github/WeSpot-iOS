//
//  SchoolRequestDTO.swift
//  LoginService
//
//  Created by eunseou on 7/30/24.
//

import Foundation

public struct SchoolListRequestDTO: Encodable {
    public let name: String
    public let cursorId: Int
    
    public init(name: String, cursorId: Int) {
        self.name = name
        self.cursorId = cursorId
    }
}


