//
//  CreateExistingTokenEntity.swift
//  LoginDomain
//
//  Created by 김도현 on 10/16/24.
//

import Foundation


public struct CreateExistingTokenEntity {
    let isProfileChanged: Bool
    public let refreshToken: String
    public let refreshTokenExpiredAt: Date
    public let accessToken: String
    let name: String
    let setting: CreateExistingMemberSettingEntity
    
    public init(
        isProfileChanged: Bool,
        refreshToken: String,
        refreshTokenExpiredAt: Date,
        accessToken: String,
        name: String,
        setting: CreateExistingMemberSettingEntity
    ) {
        self.isProfileChanged = isProfileChanged
        self.refreshToken = refreshToken
        self.refreshTokenExpiredAt = refreshTokenExpiredAt
        self.accessToken = accessToken
        self.name = name
        self.setting = setting
    }
}


public struct CreateExistingMemberSettingEntity {
    let isMarketingNotification: Bool
    let isVoteNotification: Bool
    let isMessageNotification: Bool
        
    
    public init(
        isMarketingNotification: Bool,
        isVoteNotification: Bool,
        isMessageNotification: Bool
    ) {
        self.isMarketingNotification = isMarketingNotification
        self.isVoteNotification = isVoteNotification
        self.isMessageNotification = isMessageNotification
    }
}
