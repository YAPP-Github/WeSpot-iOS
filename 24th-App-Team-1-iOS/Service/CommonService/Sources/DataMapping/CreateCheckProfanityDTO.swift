//
//  CreateCheckProfanityDTO.swift
//  CommonService
//
//  Created by eunseou on 8/4/24.
//

import Foundation

public struct CreateCheckProfanityRequestDTO: Encodable {
    public let message: String
    
    public init(message: String) {
        self.message = message
    }
}
