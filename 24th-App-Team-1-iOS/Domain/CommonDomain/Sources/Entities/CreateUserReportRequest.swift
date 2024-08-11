//
//  CreateUserReportRequest.swift
//  CommonDomain
//
//  Created by Kim dohyun on 8/10/24.
//

import Foundation

public enum CreateUserReportType: String {
    case message = "MESSAGE"
    case vote = "VOTE"
}

public struct CreateUserReportRequest {
    public let type: String
    public let targetId: Int
    
    public init(type: String, targetId: Int) {
        self.type = type
        self.targetId = targetId
    }
}
