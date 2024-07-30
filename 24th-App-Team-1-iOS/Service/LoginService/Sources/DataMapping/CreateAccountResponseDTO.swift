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
    
    public init(accessToken: String, refreshToken: String, refreshTokenExpiredAt: String) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
        self.refreshTokenExpiredAt = refreshTokenExpiredAt
    }
}


extension CreateAccountResponseDTO {
    func toDomain() -> CreateAccountResponseEntity {
        return .init(accessToken: accessToken, refreshToken: refreshToken, refreshTokenExpiredAt: refreshTokenExpiredAt)
    }
}
