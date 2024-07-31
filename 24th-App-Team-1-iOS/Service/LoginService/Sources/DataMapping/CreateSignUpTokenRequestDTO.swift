//
//  CreateSignUpTokenRequestDTO.swift
//  LoginService
//
//  Created by eunseou on 7/30/24.
//

import Foundation

public struct CreateSignUpTokenRequestDTO: Encodable {
    public let socialType: String
    public let authorizationCode: String
    public let identityToken: String
    public let fcmToken: String
    
    public init(socialType: String, authorizationCode: String, identityToken: String, fcmToken: String) {
        self.socialType = socialType
        self.authorizationCode = authorizationCode
        self.identityToken = identityToken
        self.fcmToken = fcmToken
    }
}
