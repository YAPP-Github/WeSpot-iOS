//
//  CreateUserReportRequestDTO.swift
//  CommonService
//
//  Created by Kim dohyun on 8/10/24.
//

import Foundation


public struct CreateUserReportRequestDTO: Encodable {
    public let type: String
    public let targetId: Int
    
    public init(type: String, targetId: Int) {
        self.type = type
        self.targetId = targetId
    }
}
