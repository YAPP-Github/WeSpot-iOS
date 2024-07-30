//
//  CreateSignUpTokenResponseDTO.swift
//  LoginService
//
//  Created by eunseou on 7/30/24.
//

import Foundation
import LoginDomain

public struct CreateSignUpTokenResponseDTO: Decodable {
    public let signUpToken: String
    
    public init(signUpToken: String) {
        self.signUpToken = signUpToken
    }
}


extension CreateSignUpTokenResponseDTO {
    func toDomain() -> CreateSignUpTokenResponseEntity {
        return .init(signUpToken: signUpToken)
    }
}
