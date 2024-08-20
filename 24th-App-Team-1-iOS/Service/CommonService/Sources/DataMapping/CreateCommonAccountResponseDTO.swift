//
//  CreateAccountResponseDTO.swift
//  LoginService
//
//  Created by eunseou on 7/30/24.
//

import Foundation
import CommonDomain

public struct CreateCommonAccountResponseDTO: Decodable {
    public let accessToken: String
    public let refreshToken: String
    public let refreshTokenExpiredAt: String
    
}

extension CreateCommonAccountResponseDTO {
    func toDomain() -> CreateCommonAccountResponseEntity {
        return .init(accessToken: accessToken, refreshToken: refreshToken, refreshTokenExpiredAt: refreshTokenExpiredAt)
    }
}
