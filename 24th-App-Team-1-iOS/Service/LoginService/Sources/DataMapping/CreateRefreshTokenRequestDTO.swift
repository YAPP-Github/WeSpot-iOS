//
//  CreateRefreshTokenRequestDTO.swift
//  LoginService
//
//  Created by eunseou on 7/30/24.
//

import Foundation
import LoginDomain

public struct CreateRefreshTokenRequestDTO: Encodable {
    public let token: String
   
    public init(token: String) {
        self.token = token
    }
}
