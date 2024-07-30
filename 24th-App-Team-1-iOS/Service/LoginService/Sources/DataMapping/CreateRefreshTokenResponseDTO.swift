//
//  CreateRefreshTokenResponseDTO.swift
//  LoginService
//
//  Created by eunseou on 7/30/24.
//

import Foundation
import LoginDomain

public struct CreateRefreshTokenResponseDTO: Decodable {
    public let accessToken: String
    public let refreshToken: String
    public let refreshTokenExpiredAt:String
    
    public init(accessToken: String, refreshToken: String, refreshTokenExpiredAt: String) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
        self.refreshTokenExpiredAt = refreshTokenExpiredAt
    }
}

extension CreateRefreshTokenResponseDTO {
    func toDomain() -> CreateRefreshTokenResponseEntity {
        return .init(accessToken: accessToken, refreshToken: refreshToken, refreshTokenExpiredAt: refreshTokenExpiredAt)
    }
}
