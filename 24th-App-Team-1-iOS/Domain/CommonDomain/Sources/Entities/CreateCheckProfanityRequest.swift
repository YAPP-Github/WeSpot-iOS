//
//  CreateCheckProfanityRequest.swift
//  CommonDomain
//
//  Created by eunseou on 8/4/24.
//

import Foundation

public struct CreateCheckProfanityRequest {
    public let message: String
    
    public init(message: String) {
        self.message = message
    }
}
