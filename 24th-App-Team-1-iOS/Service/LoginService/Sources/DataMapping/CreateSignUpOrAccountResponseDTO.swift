//
//  CreateSignUpOrAccountResponseDTO.swift
//  LoginService
//
//  Created by eunseou on 8/1/24.
//

import Foundation
import LoginDomain

public struct CreateSignUpOrAccountResponseDTO: Decodable {
    public let signUpTokenResponse: CreateSignUpTokenResponseDTO?
    public let accountResponse: CreateAccountResponseDTO?
    
    enum CodingKeys: String, CodingKey {
        case signUpTokenResponse
        case accountResponse
    }
    
    public init(signUpTokenResponse: CreateSignUpTokenResponseDTO?, accountResponse: CreateAccountResponseDTO?) {
        self.signUpTokenResponse = signUpTokenResponse
        self.accountResponse = accountResponse
    }
    
}

extension CreateSignUpOrAccountResponseDTO {
    func toDomain() -> CreateSignUpOrAccountResponseEntity {
        return .init(
            signUpTokenResponse: signUpTokenResponse?.toDomain(),
            accountResponse: accountResponse?.toDomain()
        )
    }
}
