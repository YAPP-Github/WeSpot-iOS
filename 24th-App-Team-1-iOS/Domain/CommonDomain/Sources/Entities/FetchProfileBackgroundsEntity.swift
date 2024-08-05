//
//  FetchProfileBackgroundsEntity.swift
//  CommonDomain
//
//  Created by eunseou on 8/6/24.
//

import Foundation


public struct FetchProfileBackgroundsResponseEntity {
    public let backgrounds: [FetchProfileBackgroundsItemEntity]
    
    public init(backgrounds: [FetchProfileBackgroundsItemEntity]) {
        self.backgrounds = backgrounds
    }
}

public struct FetchProfileBackgroundsItemEntity {
    public let id: Int
    public let color: String
    public let name: String
    
    public init(id: Int, color: String, name: String) {
        self.id = id
        self.color = color
        self.name = name
    }
}
