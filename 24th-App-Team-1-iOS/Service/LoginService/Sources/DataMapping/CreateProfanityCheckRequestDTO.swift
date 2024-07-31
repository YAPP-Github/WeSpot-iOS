//
//  CreateProfanityCheckRequestDTO.swift
//  LoginService
//
//  Created by eunseou on 7/31/24.
//

import Foundation

public struct CreateProfanityCheckRequestDTO: Encodable {
    public let message: String
    
    public init(message: String) {
        self.message = message
    }
}
