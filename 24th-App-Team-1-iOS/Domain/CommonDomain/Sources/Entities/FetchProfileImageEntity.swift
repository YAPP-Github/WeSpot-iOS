//
//  FetchProfileImageEntity.swift
//  CommonDomain
//
//  Created by eunseou on 8/6/24.
//

import Foundation

public struct FetchProfileImageResponseEntity {
    public var characters: [FetchProfileImageItemEntity]
    
    public init(characters: [FetchProfileImageItemEntity]) {
        self.characters = characters
    }
}

public struct FetchProfileImageItemEntity {
    public let id: Int
    public let name: String
    public let iconUrl: String
    
    public init(id: Int, name: String, iconUrl: String) {
        self.id = id
        self.name = name
        self.iconUrl = iconUrl
    }
}
