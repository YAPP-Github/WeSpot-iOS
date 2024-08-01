//
//  CreateRefreshTokenResponseDTO.swift
//  LoginService
//
//  Created by eunseou on 7/30/24.
//

import Foundation
import LoginDomain

public struct CreateRefreshTokenResponseDTO: Decodable {
    public let accessToken: String?
    public let refreshToken: String?
    public let refreshTokenExpiredAt:String?
    
}

extension CreateRefreshTokenResponseDTO {
    func toDomain() -> CreateRefreshTokenResponseEntity {
        return .init(accessToken: accessToken ?? "", refreshToken: refreshToken ?? "", refreshTokenExpiredAt: refreshTokenExpiredAt ?? "")
    }
}
