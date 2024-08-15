//
//  UserAlarmResponseDTO.swift
//  AllService
//
//  Created by Kim dohyun on 8/15/24.
//

import Foundation

import AllDomain


public struct UserAlarmResponseDTO: Decodable {
    public let isEnableVoteNotification: Bool
    public let isEnableMessageNotification: Bool
    public let isEnableMarketingNotification: Bool
}


extension UserAlarmResponseDTO {
    func toDomain() -> UserAlarmEntity {
        return .init(
            isEnableVoteNotification: isEnableVoteNotification,
            isEnableMessageNotification: isEnableMessageNotification,
            isEnableMarketingNotification: isEnableMarketingNotification
        )
    }
}
