//
//  CreateUserReportRequestDTO.swift
//  CommonService
//
//  Created by Kim dohyun on 8/10/24.
//

import Foundation


public struct CreateUserReportRequestDTO: Encodable {
    public let reportType: String
    public let targetId: Int
    
    public init(reportType: String, targetId: Int) {
        self.reportType = reportType
        self.targetId = targetId
    }
}
