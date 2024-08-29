//
//  UpdateUserProfileRequestDTO.swift
//  AllService
//
//  Created by Kim dohyun on 8/13/24.
//

import Foundation


public struct UpdateUserProfileRequestDTO: Encodable {
    public let introduction: String
    public let backgroundColor: String
    public let iconUrl: String
    
    public init(introduction: String, backgroundColor: String, iconUrl: String) {
        self.introduction = introduction
        self.backgroundColor = backgroundColor
        self.iconUrl = iconUrl
    }
}
