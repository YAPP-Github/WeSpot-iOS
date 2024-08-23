//
//  CreateRefreshTokenRequest.swift
//  LoginDomain
//
//  Created by eunseou on 7/30/24.
//

import Foundation

public struct CreateRefreshTokenRequest {
    public let token: String
    
    public init(token: String) {
        self.token = token
    }
}
