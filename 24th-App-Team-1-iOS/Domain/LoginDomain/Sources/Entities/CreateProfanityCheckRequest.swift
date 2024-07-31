//
//  CreateProfanityCheckRequest.swift
//  LoginDomain
//
//  Created by eunseou on 7/31/24.
//

import Foundation

public struct CreateProfanityCheckRequest {
    public let message: String
    
    public init(message: String) {
        self.message = message
    }
}
