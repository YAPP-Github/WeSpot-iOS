//
//  UpdateUserProfileRequestDTO.swift
//  AllService
//
//  Created by Kim dohyun on 8/13/24.
//

import Foundation


public struct UpdateUserProfileRequestDTO: Encodable {
    public let introduction: String
    public let profile: UpdateUserProfileItemRequestDTO
    
    public init(introduction: String, profile: UpdateUserProfileItemRequestDTO) {
        self.introduction = introduction
        self.profile = profile
    }
}

public struct UpdateUserProfileItemRequestDTO: Encodable {
    public let backgroundColor: String
    public let iconUrl: String
    
    public init(backgroundColor: String, iconUrl: String) {
        self.backgroundColor = backgroundColor
        self.iconUrl = iconUrl
    }
}
