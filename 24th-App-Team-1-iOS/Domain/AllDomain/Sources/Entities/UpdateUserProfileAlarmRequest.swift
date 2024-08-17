//
//  UpdateUserProfileAlarmRequest.swift
//  AllDomain
//
//  Created by Kim dohyun on 8/15/24.
//

import Foundation


public struct UpdateUserProfileAlarmRequest {
    public let isEnableVoteNotification: Bool
    public let isEnableMessageNotification: Bool
    public let isEnableMarketingNotification: Bool
    
    public init(
        isEnableVoteNotification: Bool,
        isEnableMessageNotification: Bool,
        isEnableMarketingNotification: Bool
    ) {
        self.isEnableVoteNotification = isEnableVoteNotification
        self.isEnableMessageNotification = isEnableMessageNotification
        self.isEnableMarketingNotification = isEnableMarketingNotification
    }
}
