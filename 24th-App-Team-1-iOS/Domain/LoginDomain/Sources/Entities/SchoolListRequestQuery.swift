//
//  FetchSchoolListRequestQuery.swift
//  LoginDomain
//
//  Created by eunseou on 7/30/24.
//

import Foundation

public struct SchoolListRequestQuery {
    public let name: String
    public let cursorId: Int // 커서 ID
    
    public init(name: String, cursorId: Int) {
        self.name = name
        self.cursorId = cursorId
    }
}
