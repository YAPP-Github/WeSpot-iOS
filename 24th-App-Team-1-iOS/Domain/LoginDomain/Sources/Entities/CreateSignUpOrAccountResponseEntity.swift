//
//  SignUpTokenResponseEntity.swift
//  LoginDomain
//
//  Created by eunseou on 8/1/24.
//

import Foundation

public struct CreateSignUpOrAccountResponseEntity {
    public let signUpTokenResponse: CreateSignUpTokenResponseEntity? //신규가입
    public let accountResponse: CreateAccountResponseEntity? // 기존가입
    
    public init(signUpTokenResponse: CreateSignUpTokenResponseEntity?, accountResponse: CreateAccountResponseEntity?) {
        self.signUpTokenResponse = signUpTokenResponse
        self.accountResponse = accountResponse
    }
}
