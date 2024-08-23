//
//  createAccountEntity.swift
//  LoginDomain
//
//  Created by eunseou on 7/30/24.
//

import Foundation

public struct CreateCommonAccountResponseEntity {
    public let accessToken: String
    public let refreshToken: String
    public let refreshTokenExpiredAt: String
    
    public init(accessToken: String, refreshToken: String, refreshTokenExpiredAt: String) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
        self.refreshTokenExpiredAt = refreshTokenExpiredAt
    }
}
