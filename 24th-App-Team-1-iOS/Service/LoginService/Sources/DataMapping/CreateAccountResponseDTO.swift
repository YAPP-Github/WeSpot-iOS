//
//  CreateAccountResponseDTO.swift
//  LoginService
//
//  Created by eunseou on 7/30/24.
//

import Foundation
import LoginDomain

public struct CreateAccountResponseDTO: Decodable {
    public let accessToken: String
    public let refreshToken: String
    public let refreshTokenExpiredAt: String
    public let setting: CreateAccountSettingResponseDTO
    public let name: String
    public let isProfileChanged: Bool
}

extension CreateAccountResponseDTO {
    public struct CreateAccountSettingResponseDTO: Decodable {
        public let isVoteNotification: Bool
        public let isMessageNotification: Bool
        public let isMarketingNotification: Bool
    }
}

extension CreateAccountResponseDTO {
    func toDomain() -> CreateAccountResponseEntity {
        return .init(
            accessToken: accessToken,
            refreshToken: refreshToken,
            refreshTokenExpiredAt: refreshTokenExpiredAt,
            setting: setting.toDomain(),
            name: name,
            isProfileChanged: isProfileChanged
        )
    }
}

extension CreateAccountResponseDTO.CreateAccountSettingResponseDTO {
    func toDomain() -> CreateAccountSettingResponseEntity {
        return .init(
            isVoteNotification: isVoteNotification,
            isMessageNotification: isMessageNotification,
            isMarketingNotification: isMarketingNotification
        )
    }
}
