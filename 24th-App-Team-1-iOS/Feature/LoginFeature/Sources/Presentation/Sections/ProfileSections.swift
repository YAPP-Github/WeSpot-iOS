//
//  ProfileSections.swift
//  LoginFeature
//
//  Created by eunseou on 8/7/24.
//

import UIKit
import Differentiator
import CommonDomain

public struct CharacterSection: SectionModelType {
    public var items: [FetchProfileImageItemEntity]
    
    public init(items: [FetchProfileImageItemEntity]) {
        self.items = items
    }
    
    public init(original: CharacterSection, items: [Item]) {
        self = original
        self.items = items
    }
}

public struct BackgroundSection: SectionModelType {
    public var items: [FetchProfileBackgroundsItemEntity]
    
    public init(items: [FetchProfileBackgroundsItemEntity]) {
        self.items = items
    }

    public init(original: BackgroundSection, items: [Item]) {
        self = original
        self.items = items
    }
}
