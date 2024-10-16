//
//  CreateExistingTokenResponseDTO.swift
//  LoginService
//
//  Created by 김도현 on 10/16/24.
//

import Foundation

import LoginDomain
import Extensions


public struct CreateExistingTokenResponseDTO: Decodable {
    let isProfileChanged: Bool
    let refreshToken: String
    let refreshTokenExpiredAt: String
    let accessToken: String
    let name: String
    let setting: CreateExistingMemberSettingResponseDTO
}



extension CreateExistingTokenResponseDTO {
    public struct CreateExistingMemberSettingResponseDTO: Decodable {
        let isMarketingNotification: Bool
        let isVoteNotification: Bool
        let isMessageNotification: Bool
    }
}

extension CreateExistingTokenResponseDTO {
    func toDomain() -> CreateExistingTokenEntity {
        return .init(
            isProfileChanged: isProfileChanged,
            refreshToken: refreshToken,
            refreshTokenExpiredAt: refreshTokenExpiredAt.toDate(with: .dashYyyyMMddhhmmss),
            accessToken: accessToken,
            name: name,
            setting: setting.toDomain()
        )
    }
}

extension CreateExistingTokenResponseDTO.CreateExistingMemberSettingResponseDTO {
    func toDomain() -> CreateExistingMemberSettingEntity {
        return .init(
            isMarketingNotification: isMarketingNotification,
            isVoteNotification: isVoteNotification,
            isMessageNotification: isMessageNotification
        )
    }
}




