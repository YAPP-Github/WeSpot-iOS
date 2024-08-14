//
//  UpdateUserProfileRequest.swift
//  AllDomain
//
//  Created by Kim dohyun on 8/13/24.
//

import Foundation


public struct UpdateUserProfileRequest {
    public let introduction: String
    public let profile: UpdateUserProfileItemRequest
    
    public init(introduction: String, profile: UpdateUserProfileItemRequest) {
        self.introduction = introduction
        self.profile = profile
    }
}

public struct UpdateUserProfileItemRequest {
    public let backgroundColor: String
    public let iconUrl: String
    
    public init(backgroundColor: String, iconUrl: String) {
        self.backgroundColor = backgroundColor
        self.iconUrl = iconUrl
    }
}
