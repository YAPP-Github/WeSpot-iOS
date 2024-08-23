//
//  ReissueToken.swift
//  Networking
//
//  Created by Kim dohyun on 8/24/24.
//

import Foundation

struct ReissueToken: Encodable {
    let token: String
}

struct AccessToken: Decodable {
    let accessToken: String
    let refreshToken: String
    let expiredAt: String
    
    
    private enum Codingkeys: String, CodingKey {
        case accessToken
        case refreshToken
        case expiredAt = "refreshTokenExpiredAt"
    }
}
