//
//  CreateAccountResponseDTO.swift
//  LoginService
//
//  Created by eunseou on 7/30/24.
//

import Foundation
import CommonDomain

public struct CreateAccountResponseDTO: Decodable {
    public let accessToken: String
    public let refreshToken: String
    public let refreshTokenExpiredAt: String
    
}

extension CreateAccountResponseDTO {
    func toDomain() -> CreateAccountResponseEntity {
        return .init(accessToken: accessToken, refreshToken: refreshToken, refreshTokenExpiredAt: refreshTokenExpiredAt)
    }
}
