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

}


extension CreateSignUpTokenResponseDTO {
    func toDomain() -> CreateSignUpTokenResponseEntity {
        return .init(signUpToken: signUpToken)
    }
}
